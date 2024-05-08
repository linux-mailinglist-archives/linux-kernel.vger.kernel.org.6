Return-Path: <linux-kernel+bounces-173529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB38C01D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C76DB21605
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301412AACE;
	Wed,  8 May 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8lpRhWx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC9127E28
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185166; cv=none; b=j87Lq7+f1RrHdZDEgzudtvzElZpviarUAspImot3kYxkvrI9T3G46A7FToIbEBksBiSWxbYOoga0Ck8KvIajySTwSqzCBclKjPZXSkxXqQRsvpO52kzgcLISQXaLe+gczJpEpuyyR0fU8E+jYulGr1DlynM7YuVZjg1I3mr30v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185166; c=relaxed/simple;
	bh=EBgZslqy6XCFdm2svCR8wdSgwC1c5tdTUgjKXU1N4nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx/68Rj57/GPF6WN9ScAt5sVGBUpgZpMcOvVqHEp+F/5uW4MnOCOfyJC3e8UZJCapIoq/WgE/cfg6gC0HX+SuXcA6DtK5u1AF15NJ5ILszgn3gx7psO4EWyYtqDfctm8/RNGfVAx1NKA06nId4Owbob4AHkTmBgkkwzS7AoTzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S8lpRhWx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a352bbd9so196375766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715185162; x=1715789962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRnWniI6weHLAZe+jcS6e3kntzKq8xydvJSod9mqGMY=;
        b=S8lpRhWxSbC2lPt9deECHsu3p+I3K+45f3bb40YBkCrupQMsboscLRFdzvWqhaHFtU
         FnzVbbOhcNlu/NKCeN8G/s41Lcn+mz+QGXBI5GCSmqa6ym2cHX1Toxyg0T807+UCFv8d
         +LVVNQHGHtzloL6RSRQ0u074eghzOJEm6L7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185162; x=1715789962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRnWniI6weHLAZe+jcS6e3kntzKq8xydvJSod9mqGMY=;
        b=ao1BmUEy0E2bz1nLKk26fX6mthbYs8ILkRG3RFAeq66+wMRFaRgbAKWkAQYA9921bA
         laKu5LLI7Nl69h9PBGOhO6oiMwQAxhzX0xqkXZ1IUJqXOrMRf83uzRzatuce+zepSY6K
         DWaba6KN8LYT4uydyg2QM2o1P8mlbsfoeUT3i8mfWiFshAwSy+Vvs/SrtMPKVloHPk/G
         yLbsAJZEB+QOHKcHN/Dkgz1SZnNnR6MMsIUB+s5Vmb4YrmF3hHxnl52tzfwPkTjy0lHZ
         JTPJPibitiJjYl1DuX6EpUSp3bBZeYgHgDrrIp5xmPnOSE0LGTrklx8b0n7gmG3v/Agd
         WvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsUE1IZho/y+Yi1ic/92x3qt29EGSMNZpK7cyAZVe6NK8Nt91ZxI5mutzt/hgJFhWp0NNO4LGoXzdxAdmMifrFpAb5X3AjrKE8SHXt
X-Gm-Message-State: AOJu0Yw/rjfBPPTZOx0OWnGoAbBpoNAt/yynRsKFyahwTAt88dhaUvsY
	G79+Myt+l4WbWDIBLV40DoUQJJfwAfSxQ4YKhmpSYQNKWRRi7AQFbB7XxDtvizEub5sMxKzmuCC
	rTlM3kA==
X-Google-Smtp-Source: AGHT+IEAdMIL3RToVewOt/c25jtUP1zjDViBguD7GElj7la+uxm9xG78K0qMiURgYCeJhWlx/mNclg==
X-Received: by 2002:a17:906:7c4f:b0:a59:c3a7:59d3 with SMTP id a640c23a62f3a-a5a1165d1d6mr11201266b.13.1715185162313;
        Wed, 08 May 2024 09:19:22 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id wt4-20020a170906ee8400b00a59e061ffdcsm2873767ejb.41.2024.05.08.09.19.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:19:21 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdd185b9so190576566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:19:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgNgPtx5qO2y51eUo3RMhutP6q9TrDmdNsRy/CsSbER5f2DT6n8BP2VuVNbs8fy5tWsIEBoYx9yrUkbbP3KR22aiyHDhVwKTBtWC2S
X-Received: by 2002:a17:906:1c10:b0:a59:9c2f:c7d4 with SMTP id
 a640c23a62f3a-a5a1167be68mr9921366b.19.1715185161053; Wed, 08 May 2024
 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
 <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com> <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
In-Reply-To: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 09:19:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
Message-ID: <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Simon Ser <contact@emersion.fr>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, 
	axboe@kernel.dk, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000003fddda0617f3aa7b"

--0000000000003fddda0617f3aa7b
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 12:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That example thing shows that we shouldn't make it a FISAME ioctl - we
> should make it a fcntl() instead, and it would just be a companion to
> F_DUPFD.
>
> Doesn't that strike everybody as a *much* cleaner interface? I think
> F_ISDUP would work very naturally indeed with F_DUPFD.

So since we already have two versions of F_DUPFD (the other being
F_DUPFD_CLOEXEC) I decided that the best thing to do is to just extend
on that existing naming pattern, and called it F_DUPFD_QUERY instead.

I'm not married to the name, so if somebody hates it, feel free to
argue otherwise.

But with that, the suggested patch would end up looking something like
the attached (I also re-ordered the existing "F_LINUX_SPECIFIC_BASE"
users, since one of them was out of numerical order).

This really feels like a very natural thing, and yes, the 'same_fd()'
function in systemd that Christian also pointed at could use this very
naturally.

Also note that I obviously haven't tested this. Because obviously this
is trivially correct and cannot possibly have any bugs. Right? RIGHT?

And yes, I did check - despite the odd jump in numbers, we've never
had anything between F_NOTIFY (+2) and F_CANCELLK (+5).

We added F_SETLEASE (+0) , F_GETLEASE (+1) and F_NOTIFY (+2) in
2.4.0-test9 (roughly October 2000, I didn't dig deeper).

And then back in 2007 we suddenly jumped to F_CANCELLK (+5) in commit
9b9d2ab4154a ("locks: add lock cancel command"). I don't know why 3/4
were shunned.

After that we had 22d2b35b200f ("F_DUPFD_CLOEXEC implementation") add
F_DUPFD_CLOEXEC (+6).

I'd have loved to put F_DUPFD_QUERY next to it, but +5 and +7 are both used.

                Linus

--0000000000003fddda0617f3aa7b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lvy090o10>
X-Attachment-Id: f_lvy090o10

IGZzL2ZjbnRsLmMgICAgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysK
IGluY2x1ZGUvdWFwaS9saW51eC9mY250bC5oIHwgMTQgKysrKysrKystLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9mY250bC5jIGIvZnMvZmNudGwuYwppbmRleCA1NGNjODVkMzMzOGUuLjFkZGI2M2Y3MDQ0NSAx
MDA2NDQKLS0tIGEvZnMvZmNudGwuYworKysgYi9mcy9mY250bC5jCkBAIC0zMjcsNiArMzI3LDI1
IEBAIHN0YXRpYyBsb25nIGZjbnRsX3NldF9yd19oaW50KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNp
Z25lZCBpbnQgY21kLAogCXJldHVybiAwOwogfQogCisvKgorICogSXMgdGhlIGZpbGUgZGVzY3Jp
cHRvciBhIGR1cCBvZiB0aGUgZmlsZT8KKyAqLworc3RhdGljIGxvbmcgZl9kdXBmZF9xdWVyeShp
bnQgZmQsIHN0cnVjdCBmaWxlICpmaWxwKQoreworCXN0cnVjdCBmZCBmID0gZmRnZXRfcmF3KGZk
KTsKKworCS8qCisJICogV2UgY2FuIGRvIHRoZSAnZmRwdXQoKScgaW1tZWRpYXRlbHksIGFzIHRo
ZSBvbmx5IHRoaW5nIHRoYXQKKwkgKiBtYXR0ZXJzIGlzIHRoZSBwb2ludGVyIHZhbHVlIHdoaWNo
IGlzbid0IGNoYW5nZWQgYnkgdGhlIGZkcHV0LgorCSAqCisJICogVGVjaG5pY2FsbHkgd2UgZGlk
bid0IG5lZWQgYSByZWYgYXQgYWxsLCBhbmQgJ2ZkZ2V0KCknIHdhcworCSAqIG92ZXJraWxsLCBi
dXQgZ2l2ZW4gb3VyIGxvY2tsZXNzIGZpbGUgcG9pbnRlciBsb29rdXAsIHRoZQorCSAqIGFsdGVy
bmF0aXZlcyBhcmUgY29tcGxpY2F0ZWQuCisJICovCisJZmRwdXQoZik7CisJcmV0dXJuIGYuZmls
ZSA9PSBmaWxwOworfQorCiBzdGF0aWMgbG9uZyBkb19mY250bChpbnQgZmQsIHVuc2lnbmVkIGlu
dCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnLAogCQlzdHJ1Y3QgZmlsZSAqZmlscCkKIHsKQEAgLTM0
Miw2ICszNjEsOSBAQCBzdGF0aWMgbG9uZyBkb19mY250bChpbnQgZmQsIHVuc2lnbmVkIGludCBj
bWQsIHVuc2lnbmVkIGxvbmcgYXJnLAogCWNhc2UgRl9EVVBGRF9DTE9FWEVDOgogCQllcnIgPSBm
X2R1cGZkKGFyZ2ksIGZpbHAsIE9fQ0xPRVhFQyk7CiAJCWJyZWFrOworCWNhc2UgRl9EVVBGRF9R
VUVSWToKKwkJZXJyID0gZl9kdXBmZF9xdWVyeShhcmdpLCBmaWxwKTsKKwkJYnJlYWs7CiAJY2Fz
ZSBGX0dFVEZEOgogCQllcnIgPSBnZXRfY2xvc2Vfb25fZXhlYyhmZCkgPyBGRF9DTE9FWEVDIDog
MDsKIAkJYnJlYWs7CkBAIC00NDYsNiArNDY4LDcgQEAgc3RhdGljIGludCBjaGVja19mY250bF9j
bWQodW5zaWduZWQgY21kKQogCXN3aXRjaCAoY21kKSB7CiAJY2FzZSBGX0RVUEZEOgogCWNhc2Ug
Rl9EVVBGRF9DTE9FWEVDOgorCWNhc2UgRl9EVVBGRF9RVUVSWToKIAljYXNlIEZfR0VURkQ6CiAJ
Y2FzZSBGX1NFVEZEOgogCWNhc2UgRl9HRVRGTDoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC9mY250bC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2ZjbnRsLmgKaW5kZXggMjgyZTkwYWVi
MTYzLi5jMGJjYzE4NWZhNDggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9mY250bC5o
CisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9mY250bC5oCkBAIC04LDYgKzgsMTQgQEAKICNkZWZp
bmUgRl9TRVRMRUFTRQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNFICsgMCkKICNkZWZpbmUgRl9HRVRM
RUFTRQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNFICsgMSkKIAorLyoKKyAqIFJlcXVlc3Qgbm9maWNh
dGlvbnMgb24gYSBkaXJlY3RvcnkuCisgKiBTZWUgYmVsb3cgZm9yIGV2ZW50cyB0aGF0IG1heSBi
ZSBub3RpZmllZC4KKyAqLworI2RlZmluZSBGX05PVElGWQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNF
ICsgMikKKworI2RlZmluZSBGX0RVUEZEX1FVRVJZCShGX0xJTlVYX1NQRUNJRklDX0JBU0UgKyAz
KQorCiAvKgogICogQ2FuY2VsIGEgYmxvY2tpbmcgcG9zaXggbG9jazsgaW50ZXJuYWwgdXNlIG9u
bHkgdW50aWwgd2UgZXhwb3NlIGFuCiAgKiBhc3luY2hyb25vdXMgbG9jayBhcGkgdG8gdXNlcnNw
YWNlOgpAQCAtMTcsMTIgKzI1LDYgQEAKIC8qIENyZWF0ZSBhIGZpbGUgZGVzY3JpcHRvciB3aXRo
IEZEX0NMT0VYRUMgc2V0LiAqLwogI2RlZmluZSBGX0RVUEZEX0NMT0VYRUMJKEZfTElOVVhfU1BF
Q0lGSUNfQkFTRSArIDYpCiAKLS8qCi0gKiBSZXF1ZXN0IG5vZmljYXRpb25zIG9uIGEgZGlyZWN0
b3J5LgotICogU2VlIGJlbG93IGZvciBldmVudHMgdGhhdCBtYXkgYmUgbm90aWZpZWQuCi0gKi8K
LSNkZWZpbmUgRl9OT1RJRlkJKEZfTElOVVhfU1BFQ0lGSUNfQkFTRSsyKQotCiAvKgogICogU2V0
IGFuZCBnZXQgb2YgcGlwZSBwYWdlIHNpemUgYXJyYXkKICAqLwo=
--0000000000003fddda0617f3aa7b--

