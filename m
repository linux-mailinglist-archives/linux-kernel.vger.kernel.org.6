Return-Path: <linux-kernel+bounces-253824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BF93277F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0357D284203
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9819AD9B;
	Tue, 16 Jul 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F8LdvZFX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576119AD4F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136592; cv=none; b=JC8Pdg5y6HSW5DOk39K5X2w6g6xJqSMMlejSZWKdriPPGoSiuMBcXKNPfJaKW6zye/StqXtf244rmtc4HnbJhPuBauet8SZFd3E7XUuv6DExc326aIeUh6XYsRv6IxdPcKqTdaP8lxYwq1TA8cpyNZLjkbuJXa5UCes4b5sLl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136592; c=relaxed/simple;
	bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmVXIGNvPs6xvbHDQ8tmFf+gnZ2W3NyFfhcjuelBXgoIgd+izdeAbg6GMOItfUp8U3kkTcm0eKoV40GT+o+ThpJEkD/5JoL6jk+QzCZUNXZHBVGrCZdUUoHJLpFJnd0mptNIDS7A1GiCFIq2gikBn6fJqnJ/AZtOudjbukouNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F8LdvZFX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so34243505e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721136588; x=1721741388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
        b=F8LdvZFXVb5rH1fq8zcOXEASi2mq5wUiGVw0rIAQujeWdtwyC3IZSnNM7sVsSwnWbz
         sA4QZztmP9DEZSBRqY9V1lu0UpBDP6gBt5+kt9tzGaSo2EVpL8O+31WHdDBoYX/flRN/
         vu308suxdFj/gRRvu2GT9VkECnVLiXn3YUb1LqZTGJC2ZeOXiizPQXDQgWz9fraQSoqY
         LlrFUAEoGXwjrhoGacddcyzDUup1tV1F/aad90YyIkzlvYSoUF2kl3xWyvo0c7sv9yYE
         DEP3hz9YFH8jtSQ3UVPQgtLZWFwGJ1kPk8vp/wL/UY+ilzkZdIpwJPYBCJ9sq56HhYG6
         RQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136588; x=1721741388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
        b=fYgywwCBTbFQ3Reculh7mKKEy+2YljQ1YbcI6wec6iWCrJ3WON+iCaVy3P30WYOn+3
         h9JfSfBTacULtd5kW76eoSp7ZfK4YOzgo1PLZjMqtpBU1dPY7dc7c2bHvbl6+uw3/Bv0
         QINaR0OmzHLkYd0OFDuVydDZr1ddBcZjWJFaWQ96lniu4ddTM5V/yws72Aa2kM2o44aP
         eRvy36K4Gtawb2B1FFM8oI8wIeqejHmR6K5P/XGQyjPYw7KP8oUGIXQ95DhQNFU7G5Qn
         e0RWQqxmOJwgqm4ABhdHomyun7xzJljFieF9F0/OBcb6oMyl4Hnht+5gu3zGPagjCPuS
         KWTw==
X-Forwarded-Encrypted: i=1; AJvYcCXrdpHX5ckR08qHHmPZVmT5q1HAwWvLRbGPjBzooIxfZmSNLAcdujagLPWSV1rC6azxLwW89r1Kuy7/gcT7dPfPBlTvGfrz0uaeAmsE
X-Gm-Message-State: AOJu0Yx2bfQThFr/hGUZ6hUlUc2haqjDNtNYuITxmhknmV//f9Q6TD0D
	5oUJl2wN2T520F+wfiZBTloG7wOMSNdiqatKrrpOKuOnHI9+h7zQnmNgfsT9rvM=
X-Google-Smtp-Source: AGHT+IGjAdQSxeEVdVw57jLUmBg/hDy2vsxlmLGLre5Ls8iiK8GxsJXzSOiFfxaji1YIcSK/8TzunQ==
X-Received: by 2002:a05:600c:314a:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-427ba642ff1mr14447565e9.16.1721136588514;
        Tue, 16 Jul 2024 06:29:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef57aesm124210045e9.45.2024.07.16.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:29:48 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:29:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jakub Kicinski <kuba@kernel.org>, Kevin Hao <haokexin@gmail.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pktgen: Use seq_putc() in pktgen_if_show()
Message-ID: <ZpZ1yOkas39bIsWa@nanopsycho.orion>
References: <cc21bbb8-e6d3-4670-9d39-f5db0f27f8ce@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc21bbb8-e6d3-4670-9d39-f5db0f27f8ce@web.de>

Sun, Jul 14, 2024 at 08:34:14PM CEST, Markus.Elfring@web.de wrote:
>From: Markus Elfring <elfring@users.sourceforge.net>
>Date: Sun, 14 Jul 2024 20:23:49 +0200
>
>Single line breaks should be put into a sequence.
>Thus use the corresponding function “seq_putc”.
>
>This issue was transformed by using the Coccinelle software.
>
>Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

