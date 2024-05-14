Return-Path: <linux-kernel+bounces-178497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C88C4E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE850B21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9812C85D;
	Tue, 14 May 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcrYibdz"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5B23776
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678099; cv=none; b=kqSa/4mD9v3M6/PA0CijR916XAtlNL1datvtLuFBPoG5Fj5sYNfVFS0dln45R5jIity7XwREZ4YiTd0gF7xi8D7fpwqtvUTI85ftr4MYaCFW+XIfTRoEF+MKR8XpE2AzlYLKF1coMWRA9HCcKMzsJLMVDqm99oqc/wdB+lx9vX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678099; c=relaxed/simple;
	bh=icODbfYucz8iEZrgAXkiUdXTmzMqOGwAC8BcHGY3Tbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl7wqqurecbrZkUB22dJcjSvay0Z8lcUVNqIvhIzszverHlcI87WbRIBSQTYRhE3DiwV7Nrl8MdPYWN+VWxaiJ5+k8JBbMxE4eG36XbTUQ7TsBViCwoPlaJKJbiT6sxNTB5wcWbNEwq2dRi9JjcxkLqFs+wXKRcRoBiJ2FJt0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcrYibdz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61be4b9869dso56130127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715678097; x=1716282897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwiEG+/aSeVq+45AIyqwaFB4r49uUU/xCyg6kp9PQPw=;
        b=qcrYibdzw8ejm3DTwFw0aQ1+8lS7v2cSxPOunX5wyzvQ3VIB47U7vUt+w0Mhhvmp7Z
         z5P7kDVAcGymKYdHPrjLIaeJK/ImNxN8LnlWBwQ7gZ/zPT1rBmsqgeNyZqgTcqhyA6Vf
         J1xROsideLdaV4Fo00Swsvk9uNh801DspFGapE3Y7wX0j3udajKlB/tjQbk3+7105lzX
         miKVMNy8RwOWj9fc+fJxPwImi7TroSZzDytSgAkfdW7PB1PqLbyYQFm+uwLuTGGXuAew
         wE3bKYXJuE1Kyek921rT/w91vx2Dh98ZXnNatzi+4zPzqP1KnuoqMqWLhVGELXnRlHfy
         fDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715678097; x=1716282897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwiEG+/aSeVq+45AIyqwaFB4r49uUU/xCyg6kp9PQPw=;
        b=PIdoDfGjJiGP6XMD185gpdp/MyTrkmTdlJ458PsoxvyB4BMiviPleyTdLxfXuXS7Iy
         n2bVX80H6lP3ZfsgmzijTiodmFlJL/D9wZKyrCp7SLDgTHj3z2LyFdig15ZxoS02ZOXe
         prtApBjVE5i6FbU9fqqhjNGCOlfRTo33nQcpCnZZBCNRm4l8bp5t/pys7lY4Ob8Z+Y2c
         ULlYhB1u9Cq1bJnDI3flUIMLlbIe8vZbQC/WvVZpwSHyruXNDZc9aAz2N50OTK6doMe+
         ZsNzr8pwW3IZiUi8T1mZLEGyxe9ghjtXcGi6nUNFcWN4BlzcdF5CNlBemCXXSBS2FG4m
         pAXA==
X-Forwarded-Encrypted: i=1; AJvYcCWC0Q9mMkHfXWy86tbZ9X5xl1mF+idEVyKd9X4JQJARc8wSRWS5HC6DVkgJLS/W01zozx1v2JBu24eH+DwnTvkGnLsb9zA+/eGKggn/
X-Gm-Message-State: AOJu0YxJAlelzO8o+RJ6uRlyB9/fnR/X/fD6XBXMXMf2c8tIky5nv/6E
	SV/7BsmR7TOyRPtvjzOhB+iC9hDQByTqpOTFBttjtMATG2OcDIsGNWR0TR7TrsNmLnLSnPMD24/
	6jiOFQIppfeTDOS0dGikRYhaKb3L786OI25GrZg==
X-Google-Smtp-Source: AGHT+IHTndqU8L/COCyzxzWqR9ztoQ2UlOx5uP/3CeJVhfGg7caer2qbn+5Tp3fV+rceU+UurQnOt0LPpOXSqHkDU54=
X-Received: by 2002:a05:690c:660e:b0:61a:af67:1cfd with SMTP id
 00721157ae682-622aff906e3mr134790487b3.5.1715678097010; Tue, 14 May 2024
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
 <20240514070033.5795-1-jtornosm@redhat.com>
In-Reply-To: <20240514070033.5795-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 14 May 2024 11:14:46 +0200
Message-ID: <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Jose
On Tue, 14 May 2024 at 09:00, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> I could not get a lot of information from the logs, but at least I
> identified the device.
> Anyway, I found the issue and the solution is being applied:
> https://lore.kernel.org/netdev/171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org/
Ah, I was not aware of it:(

Thanks a lot for the work!

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

