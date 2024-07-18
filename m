Return-Path: <linux-kernel+bounces-255791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0339934544
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5121F1F2234A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16B15C3;
	Thu, 18 Jul 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iE6rsGtt"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56B17C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261090; cv=none; b=X+rF/+pYMYBwXdpwpbHJhXCtKBS620JKchW6Zc+9RQ1ZCwql4Mt5XayB2oMOkI7/chKjcIgSCtM1nd7FtqePwF8WkftHcrhiv5V0BEsCF828SYb8KXuyVdw1TSvA8q1OJQ21A91euNpB803PIYFxxhEIyRuyllF5lsbLh+pWO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261090; c=relaxed/simple;
	bh=FAj1MClzOnm7txs8nlFo1G77N9NS2dCzEHAW+o9TMto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt6KIGn9UDTc99xIuTrXXdrkEjuajXOHUb2lssRpNnhJfEk/nXZec1zCX4c4ug22kkcnxOOIGBk7vsfI3HFlsEAKH5bZPGr5loMHCtpG6Awpj+pDvB35Bn3QIzge9cdQgX9ZR9+AbkHb5OhpuRxO04QelNXgC1VdMqTyG4Bg3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iE6rsGtt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so328763e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721261086; x=1721865886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgh/5TL5RuPEkrIYyZ+YL3lfHWM6eC22E94AhsG1cyU=;
        b=iE6rsGtt4tI9s13ZeRpYW6N7GXXikpHJOxduC05ahwLSXy2XjgO1QAo78BFEWjMJK3
         4mJXXJht5D8SGxeNV2uJ0qa5fLR1DMEk3xNA0SpvJnalJiHMul9p7RPQDWKycnbeHGZd
         Y/kzmRQhyAktb5DcBQkazVsCwEL852ekBlkj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721261086; x=1721865886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgh/5TL5RuPEkrIYyZ+YL3lfHWM6eC22E94AhsG1cyU=;
        b=mvvzqQ93wEluhEMX18WAj7k0aUXmKFg2TSSgTPjP2GbcU7GVamLzHVaa/OVQMg3/0b
         dVRr57xhWeGbtswwdwUmaH/d69r7xZhXeCQGkZGbIe3v9S/HdzVmGD5NWRdd7pNjAyWB
         Nhg6TNwkYNuNNcNricdzhRATal7MNf/1vlN/A9jDubAg9tLl82H6wJ9fb/P+ornGdLhu
         xw7JOmUOY4IRPI/InQvAim248eu1WqqIUb92efEWrVu3QyceALVTtsswJ0jc+VSK6Mne
         3biSnl8kYa/TUEUCBIstSIiw5mDLUbI1Nj3PxzYR8fqex5dfXGFHx82qFsWyZZOczIWJ
         omYA==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ/G0dHTLibyAZD5ErqG86CfPtuklplwki2ELa15mmaphd3gkin0tGmxsXSx+EXNtby5yrp0NfvT5WnrcTrrzLtD/D+wkORJfUkWr
X-Gm-Message-State: AOJu0Yw7QekifmlC/F6WGdlGQSZViwIR3bMFgWC9PQNQYROoVhAdUocp
	DVOkDCdWZ59oNFTQv/NWbn+u9udfRp/bkK4vln71l30w0c+nFh0feS6OPDS3V1ddB9dFTJzf+DT
	CnLCvRA==
X-Google-Smtp-Source: AGHT+IGRThg8G+QkXJjNDlv9YLdNjO4d95uTZYC3hfPseTqpZwaa0bXPDZCK/SYC8WxLq/H2Hb5rNA==
X-Received: by 2002:a05:6512:33d3:b0:52c:e3bd:c70b with SMTP id 2adb3069b0e04-52ee53a6f58mr2316604e87.1.1721261085705;
        Wed, 17 Jul 2024 17:04:45 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff715sm497871066b.161.2024.07.17.17.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:04:44 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c080b521so19664666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:04:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8sXyN4i8YQNVj/jREKcQjISRg4zuFsjre1KbQMSi6kMJyChH7LwHUZKKzLJrFBRsSejMhacuRp2aayXOzCFC90Mxr4lv4qrKOH7vB
X-Received: by 2002:a17:906:40d5:b0:a77:cd3c:e9b7 with SMTP id
 a640c23a62f3a-a7a0133ac71mr230759566b.57.1721261084140; Wed, 17 Jul 2024
 17:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
 <202407171017.A0930117@keescook> <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
 <202407171520.FD49AE35@keescook>
In-Reply-To: <202407171520.FD49AE35@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 17:04:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Message-ID: <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
To: Kees Cook <kees@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007ccffd061d7a5312"

--0000000000007ccffd061d7a5312
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 15:24, Kees Cook <kees@kernel.org> wrote:
>
> > In particular, this patch would make it easy to make that
> > SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE config option be a "choice"
> > where you pick "never, ptrace, always" by just changing the rules in
> > proc_is_ptracing().
>
> So the original patch could be reduced to just the single tristate option
> instead of 3 tristates? I think that would be a decent middle ground,
> and IIUC, will still provide the coverage Chrome OS is looking for[1].

So here's what I kind of think might be ok.

ENTIRELY UNTESTED! This is more of a "look, something like this,
perhaps" patch than a real one.

If somebody tests this, and it is ok for Chrome OS, you can consider
this signed-off-on, but only with actual testing. I might have gotten
something hroribly wrong.

              Linus

--0000000000007ccffd061d7a5312
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lyqie9xt0>
X-Attachment-Id: f_lyqie9xt0

IGZzL3Byb2MvYmFzZS5jICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiBzZWN1cml0eS9L
Y29uZmlnIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL3By
b2MvYmFzZS5jIGIvZnMvcHJvYy9iYXNlLmMKaW5kZXggNzJhMWFjZDAzNjc1Li5mYmU5YTk2YzJk
OTggMTAwNjQ0Ci0tLSBhL2ZzL3Byb2MvYmFzZS5jCisrKyBiL2ZzL3Byb2MvYmFzZS5jCkBAIC04
MzUsNiArODM1LDI0IEBAIHN0YXRpYyBpbnQgbWVtX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwg
c3RydWN0IGZpbGUgKmZpbGUpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGljIGJvb2wgcHJvY19t
ZW1fZm9sbF9mb3JjZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IG1tX3N0cnVjdCAqbW0pCit7
CisjaWYgZGVmaW5lZChDT05GSUdfUFJPQ19NRU1fTk9fRk9SQ0UpCisJcmV0dXJuIGZhbHNlOwor
I2VsaWYgZGVmaW5lZChDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFKQorCWJvb2wgcHRyYWNl
X2FjdGl2ZSA9IGZhbHNlOworCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGdldF9wcm9jX3Rh
c2soZmlsZV9pbm9kZShmaWxlKSk7CisKKwlpZiAodGFzaykgeworCQlwdHJhY2VfYWN0aXZlID0g
dGFzay0+cHRyYWNlICYmIHRhc2stPm1tID09IG1tICYmIHRhc2stPnBhcmVudCA9PSBjdXJyZW50
OworCQlwdXRfdGFza19zdHJ1Y3QodGFzayk7CisJfQorCXJldHVybiBwdHJhY2VfYWN0aXZlOwor
I2Vsc2UKKwlyZXR1cm4gdHJ1ZTsKKyNlbmRpZgorfQorCiBzdGF0aWMgc3NpemVfdCBtZW1fcnco
c3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCiAJCQlzaXplX3QgY291bnQsIGxv
ZmZfdCAqcHBvcywgaW50IHdyaXRlKQogewpAQCAtODU1LDcgKzg3Myw5IEBAIHN0YXRpYyBzc2l6
ZV90IG1lbV9ydyhzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoIW1t
Z2V0X25vdF96ZXJvKG1tKSkKIAkJZ290byBmcmVlOwogCi0JZmxhZ3MgPSBGT0xMX0ZPUkNFIHwg
KHdyaXRlID8gRk9MTF9XUklURSA6IDApOworCWZsYWdzID0gd3JpdGUgPyBGT0xMX1dSSVRFIDog
MDsKKwlpZiAocHJvY19tZW1fZm9sbF9mb3JjZShmaWxlLCBtbSkpCisJCWZsYWdzIHw9IEZPTExf
Rk9SQ0U7CiAKIAl3aGlsZSAoY291bnQgPiAwKSB7CiAJCXNpemVfdCB0aGlzX2xlbiA9IG1pbl90
KHNpemVfdCwgY291bnQsIFBBR0VfU0laRSk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9LY29uZmln
IGIvc2VjdXJpdHkvS2NvbmZpZwppbmRleCA0MTJlNzZmMTU3NWQuLmIyMDFhZTNmZWVhYiAxMDA2
NDQKLS0tIGEvc2VjdXJpdHkvS2NvbmZpZworKysgYi9zZWN1cml0eS9LY29uZmlnCkBAIC0xOSw2
ICsxOSwzOCBAQCBjb25maWcgU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1QKIAogCSAgSWYgeW91IGFy
ZSB1bnN1cmUgaG93IHRvIGFuc3dlciB0aGlzIHF1ZXN0aW9uLCBhbnN3ZXIgTi4KIAorY2hvaWNl
CisJcHJvbXB0ICJBbGxvdyAvcHJvYy9waWQvbWVtIGFjY2VzcyBvdmVycmlkZSIKKwlkZWZhdWx0
IFBST0NfUElEX01FTV9BTFdBWVNfRk9SQ0UKKwloZWxwCisJICBUcmFkaXRpb25hbGx5IC9wcm9j
L3BpZC9tZW0gYWxsb3dzIHVzZXJzIHRvIG92ZXJyaWRlIG1lbW9yeQorCSAgcGVybWlzc2lvbnMg
Zm9yIHVzZXJzIGxpa2UgcHRyYWNlLCBhc3N1bWluZyB0aGV5IGhhdmUgcHRyYWNlCisJICBjYXBh
YmlsaXR5LgorCisJICBUaGlzIGFsbG93cyBwZW9wbGUgdG8gbGltaXQgdGhhdCAtIGVpdGhlciBu
ZXZlciBvdmVycmlkZSwgb3IKKwkgIHJlcXVpcmUgYWN0dWFsIGFjdGl2ZSBwdHJhY2UgYXR0YWNo
bWVudC4KKworCSAgRGVmYXVsdHMgdG8gdGhlIHRyYWRpdGlvbmFsIGJlaGF2aW9yIChmb3Igbm93
KQorCitjb25maWcgUFJPQ19QSURfTUVNX0FMV0FZU19GT1JDRQorCWJvb2wgIlRyYWRpdGlvbmFs
IC9wcm9jL3BpZC9tZW0gYmVoYXZpb3IiCisJaGVscAorCSAgVGhpcyBhbGxvd3MgL3Byb2MvcGlk
L21lbSBhY2Nlc3NlcyB0byBvdmVycmlkZSBtZW1vcnkgbWFwcGluZworCSAgcGVybWlzc2lvbnMg
aWYgeW91IGhhdmUgcHRyYWNlIGFjY2VzcyByaWdodHMuCisKK2NvbmZpZyBDT05GSUdfUFJPQ19N
RU1fRk9SQ0VfUFRSQUNFCisJYm9vbCAiUmVxdWlyZSBhY3RpdmUgcHRyYWNlKCkgdXNlIGZvciBh
Y2Nlc3Mgb3ZlcnJpZGUiCisJaGVscAorCSAgVGhpcyBhbGxvd3MgL3Byb2MvcGlkL21lbSBhY2Nl
c3NlcyB0byBvdmVycmlkZSBtZW1vcnkgbWFwcGluZworCSAgcGVybWlzc2lvbnMgZm9yIGFjdGl2
ZSBwdHJhY2VycyBsaWtlIGdkYi4KKworY29uZmlnIENPTkZJR19QUk9DX01FTV9OT19GT1JDRQor
CWJvb2wgIk5ldmVyIgorCWhlbHAKKwkgIE5ldmVyIG92ZXJyaWRlIG1lbW9yeSBtYXBwaW5nIHBl
cm1pc3Npb25zCisKK2VuZGNob2ljZQorCiBjb25maWcgU0VDVVJJVFkKIAlib29sICJFbmFibGUg
ZGlmZmVyZW50IHNlY3VyaXR5IG1vZGVscyIKIAlkZXBlbmRzIG9uIFNZU0ZTCg==
--0000000000007ccffd061d7a5312--

