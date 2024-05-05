Return-Path: <linux-kernel+bounces-168954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC18BC026
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C461F21632
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C714267;
	Sun,  5 May 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSY2ZYDI"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054A8493;
	Sun,  5 May 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714906515; cv=none; b=gXGiAVloXrhaWheVW+8IZv7ZL0Ao+icCsmH1e2gTMvsZRyDpheVQ1n9GhPslpNf5Cx2WkwSblPWT6WckITDzoETKFLkFbvlU+WlBtssR1GJsYsSS1b/yd+COzav9mM77o1zC+TGLjpfEo9j6uz6s6eEJPtrXNnYxDE1o7ylR6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714906515; c=relaxed/simple;
	bh=Y8uIhb44eBGk1+SFa+ZPEs7KLQ/mGjXAsl2J04Y3OvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu3pP8ikOmB39wAiAa9e4rw5nvK+q9Iq41n64naCgwqKbghnSRu49b3TfRGzAJSLH4DcHqLex93jd2arUSPxGaiTv6Jm01Ew6vTYE903WufXLTvxwvvKqJz0KCXiTvf7PqY0CpN7zO76rWzAX73z0LnhWsl7TmF+DZHD0PjWxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSY2ZYDI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ef9ce897bso91945685a.0;
        Sun, 05 May 2024 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714906512; x=1715511312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8uIhb44eBGk1+SFa+ZPEs7KLQ/mGjXAsl2J04Y3OvQ=;
        b=gSY2ZYDIrTSx3taEcP+pW3qJppbCnKqZnX2ZeS4dQvJeCOeHFt/EGFit56XJsoggmM
         rD9aL5FyA+/NWejeuXddIDltG7zZtCJtdLcOIBnLB95qxkSTXLAFKfgSDsWWAyImrrpk
         8fWxalO4sxl/LfPTHrmJQ3O8e5Gya680hCFGLYbNoh9bSR89Jbrb5JSNEtSYyxVeyEIz
         wx4eC4r4+2XmvISp2sgfhfl7T8i1+d4jF2gozJCFrvACylPcux/XMQlXTKEoHMaHiiK6
         yA355d0c3/u/9M2iqAl92Uf+xbh4h/b0bA6gkVXIdPwkRYlJJA+Bd/dw+Rw2eSjB6DxY
         jAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714906512; x=1715511312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8uIhb44eBGk1+SFa+ZPEs7KLQ/mGjXAsl2J04Y3OvQ=;
        b=wba4s5cE88+eByKBSwAIm8h+0G8aY6BIc7/1wwbuvwjRk2PwL1JjuemCWK+yDBhmyP
         9zVXiRgot31S3qT/0NfA9CdxpW2hPDctqjhTZ7EYeEyZhbjj5ekUmyhjXM1JQbWHitQz
         PAtYcbh80oXR6sXKqPzPfD3AKY2Lz/gF4ZIUL6s+8PHtAmS/n3rWkGRu9vQe4LKfaKbs
         UIIsjPqtJ8bprIKSkcnayNQOd+dC0uImRjABWD2ROCzRBOKzHrsCE1JEjYn6TXsYbJ6C
         uy7iV4gQmM/79rXMpJtxWtKB3sfDbUxTyj6o8Oys1ncylJIuf2aPmPUP7hLTtdKtCtD6
         WYwg==
X-Forwarded-Encrypted: i=1; AJvYcCXTI5noMqXsNUZj8efYFQHo18U1722ECA7VmIKBAzcIT09zYngJr4DMrg3MbUMEnorEWpO4QVt9s1e4s/YNcyhDB+HADzL7uAcpecEM
X-Gm-Message-State: AOJu0YwkDUNZlgN2JkTdxnO11kILSA3Ua+2yAer3skGQns20nhuyiGSK
	JaR5ltnGZTdbX5ONmtAAX0N0hdZL0+M8iCpDyNmFv6+avzgn0mVdt9hF+AMQoWJ6ulIwS0kU3t6
	YmIo0X8f0vo3L3tOun4jGcZabASt2pg==
X-Google-Smtp-Source: AGHT+IGYjv5lZQA60WfnvKsCM6Vjj8w+MbxD0sbZ3nWYAO60LffIYAUPQEtNUv3QqQWYhWIM7dwEsAv/ECTuHslPmu0=
X-Received: by 2002:ac8:58d5:0:b0:43a:bcd9:5d56 with SMTP id
 u21-20020ac858d5000000b0043abcd95d56mr8392798qta.35.1714906512438; Sun, 05
 May 2024 03:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501195116.62669-1-ppbuk5246@gmail.com> <20240505085709.82688-1-ppbuk5246@gmail.com>
 <49994298-fefc-447b-a074-c6c91f8e5ca9@web.de>
In-Reply-To: <49994298-fefc-447b-a074-c6c91f8e5ca9@web.de>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Sun, 5 May 2024 11:55:01 +0100
Message-ID: <CAM7-yPRXN2kRss05HMm2Wcsm-iOnymaC7O3J4NZvqjgbnFkxqg@mail.gmail.com>
Subject: Re: [PATCH RESEND] time/timgr: Fix wrong reference when level 0 group
 allocation failed
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus :)


> Does this change approach represent a subsequent patch version instead of=
 a =E2=80=9CRESEND=E2=80=9D?
>
> How do you think about to add a patch changelog accordingly?
>
Thanks I'll do

Thanks.

