Return-Path: <linux-kernel+bounces-575666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A38A7057F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A26516C89C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD271FAC34;
	Tue, 25 Mar 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ7yJPcn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792052E3382
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917737; cv=none; b=M4oVFLlyyMJudVy0OcD7w1Xlcp2DDsOz2uYG6Mh4aBTIK65vG6uKwM/g7cANVTgrYKkCWhM8hWfuExXtdH9ldcBffBLISKeOCj28nEzwSH6QFFUP3qHsFX3Z/9zDk2kiH86J3p+5sW6Gw7VpBm1v12e9jpL8aPxZkYzdF2q3NX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917737; c=relaxed/simple;
	bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj77OPGU3OkDkElbaAEnCK/klfZ9HIuerMgm4mRzmnBUX/FWDThbRqodT9CNOHAJ/pn+wcPpGLzm8ifcRCGgFx2ppsy5orVq/N2FOU0OfF25fyirLbjmN+xcXfNwTo/fWL2vEVPd8Y15VYn+OMusckV5XiTsCy2x/aYP6WwQ1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQ7yJPcn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
	b=WQ7yJPcnDImSxXSuqpJfOG5sMyKuomUIYYviu+Ov9Ny054oeyVDASGD+H+h0jQd+Th1NdT
	OWqbR2XDQrcTi1MJ9MSPAdYRWO61yccYEoMFQHmIxhhbz8tAG+spwocrrpCcb99tXEp1Lv
	JNWq/fUV1quDosWXKb81+y9GRjYkE1Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-GP31lPQUM0WHSVuEBM1TNw-1; Tue, 25 Mar 2025 11:48:51 -0400
X-MC-Unique: GP31lPQUM0WHSVuEBM1TNw-1
X-Mimecast-MFC-AGG-ID: GP31lPQUM0WHSVuEBM1TNw_1742917730
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so691968966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917730; x=1743522530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
        b=SIhd1FnFvdhzkTBf1Brv5jXQDzxIEtWxqw0qVNK+RGi20b+7FXuK9mDGPHyBXHVTPC
         xYFnR46oGblSIuSIxQcU+699FtF7sbpBtEjnhhdTKjybDa9m5keqYxXmSYMDkGyI+Oxk
         tBJxzZ0FhugK+EjRpaZwVDMd8dAEnCbb7IQuGYQRvNYvTcWPaW71hPOFu0lKs8AC3UA3
         j498w5Hzp0LjICIGa7d4fd7G2BdG3JeTyEEQR3gfnO+0frc0+0YCBpLsh0zJjPXxAomN
         jJnOqg3a2vBaCo6d3n06RYVd0ZrGSR6ZxxUQaPNHqf7Wx0FFxPjnDcJ498d2CrTa1Me0
         kQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdsENrv6vBZP1W5kcQPXRMum2Ovg7+iQlyrQcIrAVQ9t0zTtv0U5tzeiqQn5R/Va+0VqgCaCxGBYd6OF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGOGXZqfg12ABFHvX0I07MlEC+/+CcvpT8syFTqxPx6156W5z
	kM6q7a1cEyeZvzxQgQ/iiL1NYTht/5SSezUpXwxuO99bFIUQixOf6EKTLSt/63aNbfJvhpJ02v6
	52SWM8DJz20RYH/udirlsgfX3RllNadcuk+ctEbYJzRkoTS3kkdxHhCJVjPU5nMW4IN8WGfdXPo
	PXGpmIkGTwa3F3Rn6Ls6MMB0Pq+2Qw7UDKWiq5
X-Gm-Gg: ASbGncsjGYXO38Vww9/Apq2z1XTZ15sdxNPjsxxvDGrunCB64UZBxZgDSX3niqFh0R8
	0FtUs+SyINkS2S+7ruCZ4W8/Fy3MvQUfbGC/tFsnxjWEJeDCoPiCe5tPYY6C98HXmOxPU9QZKdA
	==
X-Received: by 2002:a17:907:f50a:b0:ac3:45b5:d325 with SMTP id a640c23a62f3a-ac3f253011emr1834030466b.52.1742917730277;
        Tue, 25 Mar 2025 08:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD64oBfGmIy4l7ipkxycYxKe6ZIbenXBCa1X1NVXvuOTgJbZUFc6bXWv82qD2ySlajcuBwkr3lQOUImvYCoOM=
X-Received: by 2002:a17:907:f50a:b0:ac3:45b5:d325 with SMTP id
 a640c23a62f3a-ac3f253011emr1834028166b.52.1742917729882; Tue, 25 Mar 2025
 08:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322183439.393533-2-costa.shul@redhat.com>
In-Reply-To: <20250322183439.393533-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:48:36 +0100
X-Gm-Features: AQ5f1Jr0dsAtsjzTVe3U7QzJt6ah2IQQOliT5wpbbU_ZQBdQgNVZsG0gU14KJaI
Message-ID: <CAP4=nvTXEO=i7Rf4ONOpr89XoFLnkGYKp78xMLZk4yYh6dnZEA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Fix crash due to NULL record dereference
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 22. 3. 2025 v 19:40 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The previous patch introduced a crash by dereferencing record,
> which can be NULL.
>
> Add checks to prevent the crash.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

This is a duplicate of my fix [1]. I added a NULL check inside the
function and made the callers pass NULL if the record instance is not
initialized.

[1] https://lore.kernel.org/linux-trace-kernel/20250313141034.299117-1-tglo=
zar@redhat.com/

Tomas


