Return-Path: <linux-kernel+bounces-268312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D7942316
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27341F250BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE94193063;
	Tue, 30 Jul 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aL5sXsed"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB90191F8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379480; cv=none; b=KYChfG28OXFoVSseqKEjaWoPQF1vQ3LxKi/EYrRLt22J2ogAIdDYw0zQM7hzrPu11+CPfT05iYiUSRr8TGqt80SogSBvfkoYhJ3A9VuRs+e1PS5kRvgOdA2iKCCIAs1BKMSs9hEfPggr2p8PsnwH9461kz9Ejq6jYsgUidyx91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379480; c=relaxed/simple;
	bh=nUPIu4Vfnva+ZvYf0WswNhJxtB79jMrYN0oSi2hoRPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Glzq2pDOm3bAzndFRMgL5BQMCZkwpX3Cv8xQWVIgrrWLu8ioJTuoB6A9Crq1tdycs4FVKYLnquIPGajoszAKNvB6XWu6X9W7Q78Fj9O5MlAVKtEBoggdG+GQNlCnuHOiuummuYk4s4mgqkULaZpV9nLsHfrem4nmMnLCcH/HGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aL5sXsed; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52fc4388a64so8688593e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722379476; x=1722984276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aVok3QjVVn6gnM13EoNxYFfbYWcnFAKc2fMvNq85Bsk=;
        b=aL5sXsed2HrDK+49BBu4w6TTON/z1k/ZTgMe1CcoJvdOQHnLrfHwWq/ct85ScfzY3N
         HJjdcE7DOhGqUTZmYsHxYWfGEnKrXMNaAs7mpKYofigWNlisw3Pgu4XXtsYq9DUzQaRV
         TsniwfQtQBhxcSg3E9BeDmAa7KK90e48G1D8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379476; x=1722984276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVok3QjVVn6gnM13EoNxYFfbYWcnFAKc2fMvNq85Bsk=;
        b=DRloPso+s0h19TBz9gUxY3fs9deJfRC3rrjQFeRm4lSBzsdg8Pw+8elrCVwm16l5KO
         Bki4eZZAaVV+xKcj7VMP5oHaK5Fs3yNvpTsK1JVDTPZLbZjcsgY8ZRsbUBv5bsDSBP9F
         oQqZ1nL7zSwlJ5sCgaVRf09FYxhFmOyLyiGNup/8n2Td3q3PMOLnePQXzhoC7SpT7U9f
         KPrp0qEuCUePjiollinQqgz/tUH1j1qZnthIaTwgxbVjczvIahgutFqkE7ZB+dBVE/xR
         CE7Y0L9Cs/NtRAhJ/fgS0mYCaKiozvAY5XB9DTGXezx9DeRRFWGP+lBpVV5xyoSRnPUS
         NQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWM3IvoN2/WAFGlkvRXRRzAXEDiytJzE49aoN+Otp6Q+v0CuS8+umKpBpstaQjSbk9WVfLjAdK2TeJlM+NSg8U+i/bF2tV4hZhZFrBv
X-Gm-Message-State: AOJu0Yy1Pqxk4MkMDWh2ePd9MvfYmhSPo+5onEgjWAQr/Iyf3C9MEF0x
	GZ4R/HBJFItzw749P5dpptQNugYsSqge3PfwA2MWsQRSZHi24AibkqIAWIPeY7w7KaHmQOTfgG2
	507HhwQ==
X-Google-Smtp-Source: AGHT+IHGyna7YsBpUeesM+/OfT6UpAJBl/kEuDXrSUgQaZNtQTZjV6FzOLM3PtYRv8y6bOj4f8w3jg==
X-Received: by 2002:ac2:5b0f:0:b0:52f:c10d:21f0 with SMTP id 2adb3069b0e04-5309b2d8ac3mr7220421e87.54.1722379476004;
        Tue, 30 Jul 2024 15:44:36 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c1a0d2sm2031573e87.224.2024.07.30.15.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:44:34 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f032cb782dso56209231fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlkwBFJSYxbefBdF76FiAGQqcL/+f8shGeeRWWMjLuEAHAI4qqbsfte33Pmj1Dli0h5blr+SKq9OIrQ9+4gf2JcXjZfa8cZEilACXG
X-Received: by 2002:a05:651c:4ca:b0:2ef:1db2:c02c with SMTP id
 38308e7fff4ca-2f12edf9d3bmr106863941fa.10.1722379474221; Tue, 30 Jul 2024
 15:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com> <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com> <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com> <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com>
In-Reply-To: <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 15:44:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
Message-ID: <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000bb9224061e7eb857"

--000000000000bb9224061e7eb857
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 14:48, David Laight <David.Laight@aculab.com> wrote:
>
> Have you a plan to 'fix' min3() ?

I didn't have a test-case that showed it being a problem, particularly
after min() no longer expands exponentially, but maybe something like
the attached would work?

All the infrastructure is in place for it, this just uses it.

Does this work for you? Was there some particularly bad case you were
looking at that I missed?

           Linus

--000000000000bb9224061e7eb857
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lz90996r0>
X-Attachment-Id: f_lz90996r0

IGluY2x1ZGUvbGludXgvbWlubWF4LmggfCAxMiArKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbWlubWF4LmggYi9pbmNsdWRlL2xpbnV4L21pbm1heC5oCmluZGV4IDQxZGE2Zjg1YTQw
Ny4uOTgwMDhkZDkyMTUzIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oCisrKyBi
L2luY2x1ZGUvbGludXgvbWlubWF4LmgKQEAgLTE1MiwxMyArMTUyLDIwIEBACiAjZGVmaW5lIHVt
YXgoeCwgeSkJXAogCV9fY2FyZWZ1bF9jbXAobWF4LCAoeCkgKyAwdSArIDB1bCArIDB1bGwsICh5
KSArIDB1ICsgMHVsICsgMHVsbCkKIAorI2RlZmluZSBfX2NhcmVmdWxfb3AzKG9wLCB4LCB5LCB6
LCB1eCwgdXksIHV6KSAoewkJCVwKKwlfX2F1dG9fdHlwZSB1eCA9ICh4KTsgX19hdXRvX3R5cGUg
dXkgPSAoeSk7X19hdXRvX3R5cGUgdXogPSAoeik7XAorCUJVSUxEX0JVR19PTl9NU0coIV9fdHlw
ZXNfb2szKHgseSx6LHV4LHV5LHV6KSwJCQlcCisJCSNvcCIzKCIjeCIsICIjeSIsICIjeiIpIHNp
Z25lZG5lc3MgZXJyb3IiKTsJCVwKKwlfX2NtcChvcCwgdXgsIF9fY21wKG9wLCB1eSwgdXopKTsg
fSkKKwogLyoqCiAgKiBtaW4zIC0gcmV0dXJuIG1pbmltdW0gb2YgdGhyZWUgdmFsdWVzCiAgKiBA
eDogZmlyc3QgdmFsdWUKICAqIEB5OiBzZWNvbmQgdmFsdWUKICAqIEB6OiB0aGlyZCB2YWx1ZQog
ICovCi0jZGVmaW5lIG1pbjMoeCwgeSwgeikgbWluKCh0eXBlb2YoeCkpbWluKHgsIHkpLCB6KQor
I2RlZmluZSBtaW4zKHgsIHksIHopIFwKKwlfX2NhcmVmdWxfb3AzKG1pbiwgeCwgeSwgeiwgX19V
TklRVUVfSUQoeF8pLCBfX1VOSVFVRV9JRCh5XyksIF9fVU5JUVVFX0lEKHpfKSkKIAogLyoqCiAg
KiBtYXgzIC0gcmV0dXJuIG1heGltdW0gb2YgdGhyZWUgdmFsdWVzCkBAIC0xNjYsNyArMTczLDgg
QEAKICAqIEB5OiBzZWNvbmQgdmFsdWUKICAqIEB6OiB0aGlyZCB2YWx1ZQogICovCi0jZGVmaW5l
IG1heDMoeCwgeSwgeikgbWF4KCh0eXBlb2YoeCkpbWF4KHgsIHkpLCB6KQorI2RlZmluZSBtYXgz
KHgsIHksIHopIFwKKwlfX2NhcmVmdWxfb3AzKG1heCwgeCwgeSwgeiwgX19VTklRVUVfSUQoeF8p
LCBfX1VOSVFVRV9JRCh5XyksIF9fVU5JUVVFX0lEKHpfKSkKIAogLyoqCiAgKiBtaW5fbm90X3pl
cm8gLSByZXR1cm4gdGhlIG1pbmltdW0gdGhhdCBpcyBfbm90XyB6ZXJvLCB1bmxlc3MgYm90aCBh
cmUgemVybwo=
--000000000000bb9224061e7eb857--

