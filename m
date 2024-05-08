Return-Path: <linux-kernel+bounces-172700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF88BF59E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E80285786
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56417C60;
	Wed,  8 May 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcIa/Bhi"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66D1758E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146970; cv=none; b=Pn1HxZebziWuaQ+oKABJY1HWrSiflsnoKDounXiOReFPk+Xz83qMgpPzrFyb8UJjJK5FfB6cAlv2+Vha+gV4jxB29Lfa2kHnU0jbZvw5a6FnRnvEdM+JQw1rOPbV1FKbHQ1RW98Edz8aDQOJnO/hQHzVkbneBkFQUVD+PY3TbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146970; c=relaxed/simple;
	bh=Dm8oAyDId/BGzFguq4WTwi8cfuw6NO7IL3CwBWqI+YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFo5CDmDFlK7Ivhd5spME3sVFsN0tAsMn78KGO+CtzAZzRrtvjylXMkaLDK0f3HkJPDwNGScfBKfkLjWuHhsF2HshRUfEXXuV40SdyIcv8Bw0uEm83n928ED5HZW/8/cjrgP+ddy9vL8QETIfeUKvvWcf9Cse0E90CsdnevWuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcIa/Bhi; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61bed5ce32fso43600747b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715146968; x=1715751768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8is/8kMXXquytRmRTTojazPRXnlwoDhApNzUo9b3+OQ=;
        b=KcIa/BhiRW5xS3AQueE75g59SNsIUK7uFzmASvX+e254/TVlCrWRvk69o5U56MBJVJ
         +6xNpGUi81LEsfeMlpf6hPyxUdTvREE/rIno9US2AeUv9/8rmuCvX8qkUtO/S4P8x9A7
         gNql39MBxjLtQik8dAb4RLs/g8TlxD2m+dPOYdISqkTDJKRFqa+foXMAvQz00Bh58S6/
         LHt55T6ueY+mS8FEKFflcKay5dgT8SAdfyf0xb9P5MfFn4/7Zh96p49GdgRLyEj69xui
         BSmXw9E1iueHRuA82pmMB9+39RgIgqlXs/LhwyNLzhxGWgRGtzBOCF67qE5Z49dGQA17
         TOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715146968; x=1715751768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8is/8kMXXquytRmRTTojazPRXnlwoDhApNzUo9b3+OQ=;
        b=RarGravilvmXjrQHNNpIRyQZAnzh0h9RQJP+uZEegEKok3WV6Cexfvq2LqTd9VkR/A
         2xCNxc2fS8pViUZ51xWJ/jxj05ijdHs3Odv2pufS+hylE2SwcldRGSXnskdnXKPXCwuS
         778eIfKlpJobea2zF0G12kAlPggwn2JHpHpoI/2Vaqq1o9950WIXHrmovVFsT2vPq3at
         kjBR4qpQdZ+zsHTKbDgmLCozKzgD3IwJladJiMAP+y4MFM9l2zcrh9HkeGDNMUJYUL7Q
         p51sYsqHiWYlKBBb9nB10HyuhfSp3S0T1XZfLJOyFiDRBRg0Rc43IIKBGSo1haceARcf
         bIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK4cTqQm/w3DkUoqJgv9rwEHjhqQF9wm6Dmozry99yr42DyffXbNODZyjgh63SnSHX/waXR6eaqijm7l2dcF04qz9FoALbat4Ay6gk
X-Gm-Message-State: AOJu0YwTlFLGtIVxBBq353JGI0jxq1ScixkJTiA0bKNrZPbgR885h7he
	Gqg6+0CI/OMVa1TcjXgBVcOamve4wShi5HZ4OW5vIEDV0dai7BEkyfTE4O5HFEU+VJgMA7ugpOJ
	pRmVD+Szqngv7dYajP7sKHV9RSbKOK6RqdUql2Q==
X-Google-Smtp-Source: AGHT+IG24D1NQIZ27R3N3aZ27xeVwEEsTRm5xCfdyZ/r6uMBhrpmntSpIHxXqQrXwipOem08bGFWGZKtDUaSlW68z1M=
X-Received: by 2002:a81:7182:0:b0:61b:3356:a679 with SMTP id
 00721157ae682-62085a6fd15mr20951377b3.17.1715146967118; Tue, 07 May 2024
 22:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430082717.65f26140@kernel.org> <20240430160057.557295-1-jtornosm@redhat.com>
In-Reply-To: <20240430160057.557295-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Wed, 8 May 2024 13:42:36 +0800
Message-ID: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	vadim.fedorenko@linux.dev, Sumit Semwal <sumit.semwal@linaro.org>, 
	John Stultz <jstultz@google.com>, Viktor Martensson <vmartensson@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Wed, 1 May 2024 at 00:01, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> > v6.8.8 has 56f78615b already. We need another patch, Jose?
>
> Hello Jakub,
>
> I will try to analyze it during the next week (I will be out until then).
>

Not sure if you have checked it already, this commit causes an issue for the
db845c + ACK android15-6.6[1] + AOSP main Android configuration, the
ethernet does not work,
there is no ip address assigned, like:
    db845c:/ # ifconfig eth0
    eth0      Link encap:Ethernet  HWaddr 02:00:89:7a:fb:61  Driver ax88179_178a
              UP BROADCAST MULTICAST  MTU:1500  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 TX bytes:0

    db845c:/ #
if I have this change reverted, then it will work again:
    db845c:/ # ifconfig eth0
    eth0      Link encap:Ethernet  HWaddr 02:00:89:7a:fb:61  Driver ax88179_178a
              inet addr:192.168.1.10  Bcast:192.168.1.255  Mask:255.255.255.0
              inet6 addr: 240e:305:2c88:4700:4b6d:926d:1592:fc5e/64
Scope: Global
              inet6 addr: 240e:305:2c88:4700:edc9:86ec:7c5e:b028/64
Scope: Global
              inet6 addr: fe80::32ce:8a2e:269d:e53f/64 Scope: Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:966 errors:0 dropped:33 overruns:0 frame:0
              TX packets:475 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:51193 TX bytes:39472

    db845c:/ #

One thing to be noted here is that, during the boot, the MAC address
will be reassigned
to make sure each board has its own unique MAC address with the
following commands:
    /vendor/bin/ifconfig eth0 down
    /vendor/bin/ifconfig eth0 hw ether "${ETHADDR}"
    /vendor/bin/ifconfig eth0 up


Could you please help have a check and fix or give some suggestions on
this issue?

[1]: https://android.googlesource.com/kernel/common/+/refs/heads/android15-6.6
-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

