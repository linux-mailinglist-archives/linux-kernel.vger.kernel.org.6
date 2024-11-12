Return-Path: <linux-kernel+bounces-406668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915839C6204
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8641F248A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33EB2194B2;
	Tue, 12 Nov 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQtWiJ2+"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351821894F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441560; cv=none; b=XpLDYenhZyFVSNw/KdFja1c5hfrfSeU/spTYhnbPuHxEkEjuynRRh3vL1yr7m0U+fbdc3cl/vKgohqasF1BqMHucc6pV2B53BytkTJvRCgk25IOtDgzR/zbaieNVyrvRIXTp19K9ccPuAQdmPkUH8mCG6QMKkqVZw8lr5NawFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441560; c=relaxed/simple;
	bh=+E2mWVQga8SPclSL6l2a5Ey348OcVgIUUdZW9s7RwNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVQrsYJkc5baYJZtVnDS5QCU60QGKkINm3YyxOZEsAbX65V6b/TMHPC6QMizPBny0hu5YsF0k+pJN30teWw2AoZRgEtgEgmPOyF1d3gGIPE9ZUzvOrKDEdXn8rWGKGyv+CGCkdc2eYD59o8/yCMTtBSWMYrJrySluT3FIWgDuAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQtWiJ2+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so7120295e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731441555; x=1732046355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwZYkRsX6YfbHFG1wqjaJ7mBPncYDizCUMOUgXXp8/w=;
        b=eQtWiJ2+XHGjgt08iO4kWE9yJbXiz//OEgoaQo8XvSu0/VvztuvWO6csSJ4QCSdkhM
         6UDKnHUA0rLH7pj73PzJHxXYO58hnABkqjnIWE+8sUzvStNTKnyPxz2WqFG5wzZfqtLZ
         43y1hHGsQTTl5oYjlqjc8mPQt3tEe35m+HkGqyVpE8wVMbWMJkpbfS934kb0V+mmu2Hi
         IPuQ6zE+eQdqk5k+/Gw6dgfu32YsH+oDT7y6upu3KW3dRTc9FNUirAfYFzD3030E3qOG
         27bwWKO3CePuuFzICkX2B3Ptniy5KkpQSn7fvtp3JmprOPk7f2DcKD14DSVoV+nZz1VA
         tG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441555; x=1732046355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwZYkRsX6YfbHFG1wqjaJ7mBPncYDizCUMOUgXXp8/w=;
        b=CFIDCh3E6ag5SwgGRvzLKA6hWuSckgaIOGva79RiyjLTyHFxQWB7t5IssgCtV345rA
         jvi+1UT0IB/gJeUoWdjnF1cLkwF/ZyjV+jhrPcM+m0W98SI0bkQl/GTfFm+rrv8NBXFN
         M1uQ/FF83xsTSEgYthPOVacGw4gI2GE7TPP+Bu8psG8G/FvmkboK/9vK2abnABBicTAC
         LQCvu14BOYCiSiDnxdN42fbtPKJWaoiET48NGOV3Ag3y0DoqeOQHvUMl/l59RpB5y2hI
         8q/gdbd+UWSxBGketgwotmih9Q4JNOhHkxljaSdif+cQjWir+lUFYzKMVVhGBAZwypZV
         g+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV/KYfDeus6BLymnhFTXNCH//dHe0o0DWUn0wB+qjYKacSmC5kI5tsYT6ZhQQadUiOVSX75nOcHELE9liE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4hvWJAaloc16HI00h6xElR4RVrZINHmf1Df0LNrsuu6ievAj
	sc95KFdhaqimwBBw7l8XeQUqsVcB8CzS2zQwTv/CgDqjcyQ6pPPkKWMCNxKI0YOhxnkrIAmhCuQ
	MirRYQHF8ZiliatHrLyDPg4Cde4Q=
X-Google-Smtp-Source: AGHT+IFbIllrfwGO0FHSAMmQGvZalC2B71K7rphbyHwgZ89xdxqrXmhCIojBrbJ1KXYBreY85U66dvhWmtBRR3bweu8=
X-Received: by 2002:a05:6512:ea8:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-53d862cd25bmr8266588e87.9.1731441555207; Tue, 12 Nov 2024
 11:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010133253.30311-1-diogo.ivo@tecnico.ulisboa.pt>
 <041511ee-4556-422a-8604-30b5e0dfd21c@leemhuis.info> <D5DDUQJOZ4HW.1XDOASECJR714@tecnico.ulisboa.pt>
 <44c39c87-90e2-4a74-a185-752c14f6d711@leemhuis.info>
In-Reply-To: <44c39c87-90e2-4a74-a185-752c14f6d711@leemhuis.info>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 13 Nov 2024 05:59:03 +1000
Message-ID: <CAPM=9txeL+WxYuuGYyhGouXYC0=Y=YS=k=-4G74JbfT2mvkn2g@mail.gmail.com>
Subject: Re: [REGRESSION] GM20B pmu timeout
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: kherbst@redhat.com, linux-kernel@vger.kernel.org, dakr@redhat.com, 
	lyude@redhat.com, bskeggs@nvidia.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Danilo Krummrich <dakr@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d9c7020626bca665"

--000000000000d9c7020626bca665
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 22:34, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing Danilo, who committed the culprit]
>
> On 04.11.24 13:11, Diogo Ivo wrote:
> > On Tue Oct 15, 2024 at 7:13 PM WEST, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 10.10.24 15:32, Diogo Ivo wrote:
> >>>
> >>> Somewhere between 6.11-rc4 and 6.11-rc5 the following error message is displayed
> >>> when trying to initialize a nvc0_screen on the Tegra X1's GM20B:
> >>>
> >>> [ 34.431210] nouveau 57000000.gpu: pmu:hpq: timeout waiting for queue ready
> >>> [ 34.438145] nouveau 57000000.gpu: gr: init failed, -110
> >>> nvc0_screen_create:1075 - Error allocating PGRAPH context for M2MF: -110
> >>> failed to create GPU screen
> >>
> >> Thx for the report. Hmmm. No reply so far. :-/

Apologies for the delay and thanks to Thorsten for bringing it up again,

Does the attached patch fix it?

if you say it does I'll send it out properly.

Dave.

--000000000000d9c7020626bca665
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-nouveau-sync-dma-after-setup-is-called.patch"
Content-Disposition: attachment; 
	filename="0001-nouveau-sync-dma-after-setup-is-called.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3evkw6p0>
X-Attachment-Id: f_m3evkw6p0

RnJvbSBjMGY3OGIyMjZkYTQxNzczNTk0NTAwNjllNGExYWYyNDQyNTNmZGRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDEzIE5vdiAyMDI0IDA1OjU3OjAzICsxMDAwClN1YmplY3Q6IFtQQVRDSF0gbm91dmVh
dTogc3luYyBkbWEgYWZ0ZXIgc2V0dXAgaXMgY2FsbGVkLgoKc2V0dXAgc2VlbXMgdG8gY2hhbmdl
IHNvbWUgb2YgdGhlIGZ3IGNvbnRlbnRzLCBzbyBzeW5jIGFmdGVyIGl0LgoKU2lnbmVkLW9mZi1i
eTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
bm91dmVhdS9udmttL2ZhbGNvbi9mdy5jIHwgMTEgKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL25vdXZlYXUvbnZrbS9mYWxjb24vZncuYyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1
L252a20vZmFsY29uL2Z3LmMKaW5kZXggYTFjODU0NWYxMjQ5Li5jYWM2ZDY0YWI2N2QgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L252a20vZmFsY29uL2Z3LmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9mYWxjb24vZncuYwpAQCAtODksMTEgKzg5LDYgQEAg
bnZrbV9mYWxjb25fZndfYm9vdChzdHJ1Y3QgbnZrbV9mYWxjb25fZncgKmZ3LCBzdHJ1Y3QgbnZr
bV9zdWJkZXYgKnVzZXIsCiAJCW52a21fZmFsY29uX2Z3X2R0b3Jfc2lncyhmdyk7CiAJfQogCi0J
LyogYWZ0ZXIgbGFzdCB3cml0ZSB0byB0aGUgaW1nLCBzeW5jIGRtYSBtYXBwaW5ncyAqLwotCWRt
YV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKGZ3LT5mdy5kZXZpY2UtPmRldiwKLQkJCQkgICBmdy0+
ZncucGh5cywKLQkJCQkgICBzZ19kbWFfbGVuKCZmdy0+ZncubWVtLnNnbCksCi0JCQkJICAgRE1B
X1RPX0RFVklDRSk7CiAKIAlGTENORldfREJHKGZ3LCAicmVzZXR0aW5nIik7CiAJZnctPmZ1bmMt
PnJlc2V0KGZ3KTsKQEAgLTEwNSw2ICsxMDAsMTIgQEAgbnZrbV9mYWxjb25fZndfYm9vdChzdHJ1
Y3QgbnZrbV9mYWxjb25fZncgKmZ3LCBzdHJ1Y3QgbnZrbV9zdWJkZXYgKnVzZXIsCiAJCQlnb3Rv
IGRvbmU7CiAJfQogCisJLyogYWZ0ZXIgbGFzdCB3cml0ZSB0byB0aGUgaW1nLCBzeW5jIGRtYSBt
YXBwaW5ncyAqLworCWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKGZ3LT5mdy5kZXZpY2UtPmRl
diwKKwkJCQkgICBmdy0+ZncucGh5cywKKwkJCQkgICBzZ19kbWFfbGVuKCZmdy0+ZncubWVtLnNn
bCksCisJCQkJICAgRE1BX1RPX0RFVklDRSk7CisKIAlyZXQgPSBmdy0+ZnVuYy0+bG9hZChmdyk7
CiAJaWYgKHJldCkKIAkJZ290byBkb25lOwotLSAKMi40Ny4wCgo=
--000000000000d9c7020626bca665--

