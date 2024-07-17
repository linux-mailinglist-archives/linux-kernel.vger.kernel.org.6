Return-Path: <linux-kernel+bounces-254910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F40933929
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6011C20D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4E10953;
	Wed, 17 Jul 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nvCTqga"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D11BC39
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205439; cv=none; b=OGZC2P3guuxm+3JGuiha5oK3GxJFmoltY6SgExsmGCJ2jIQbWwPATrPdRGDyTZPgZn8BWGl+UJCUDASHx+ZiVI0Xc/5lT1GI8ylqamAz2jRas5ed2R/9ws/peb7sKWI5CG54YT2cToUHSfBgHiMLA15HJobJ57tBVwhyrx6Qk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205439; c=relaxed/simple;
	bh=hoQpFhzvy/0Y1D1v33lPjhtmyeKl0Rs0H4Mgj3xz5AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npdx6I2R2ePap/RAgwYpQ2z8WmUMgA5ArQTC4GZ3vkWdrMHeS1+CPy2e4xBABOhN6U0a1TvUBUg2/O1YswlJu61Zrln/JS/bfAG4McjCGfDTuIPQfwA8A0IaAnsi3f0VJNX+yk/N66mB+8GGXporXVWI1XaJpwS20MZoV8H2pHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nvCTqga; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44e534a1fbeso156311cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721205437; x=1721810237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hoQpFhzvy/0Y1D1v33lPjhtmyeKl0Rs0H4Mgj3xz5AQ=;
        b=0nvCTqgajVXuD8o8zIWQz/+8l31vvL++lYjxZFMX8ZVE8Pf2n38aGzN++/3OqeqJ3V
         E2ifpZcvWVtgwPJo8EnxF95ijMn06hvcDOWlwjz8HiTdmzzB4tNU/5ogHnzVoDd2Zlvj
         6SOFM0Ozb7Fh683cngVmDkBqsvBUVgYhLlV1M7Pchaz2XUaI7RSL3pyqPgvJeewRFXGj
         ka3Bvxa7ZIzTWyP9ydY2VOnfVFT25a9ozeZh75+vEHR+90ANfwxQy/Rq9QHryLg2B8c0
         idzxOpMsQOrX2JgsXAz4u3upS6GXoJ4hGH0h54scDVouQhU9O9K0cWMZP5SwJ1faS5WE
         8Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205437; x=1721810237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoQpFhzvy/0Y1D1v33lPjhtmyeKl0Rs0H4Mgj3xz5AQ=;
        b=DEutPSHdgFgQg9egyDIB+b+KPG/DSK+WIH2j9Tj3MjDYlQr+zlSF7uFaU6jKgZH3gZ
         g6iDjmsrvq7YwyM9rgwUVb4Q7Jdwdh9VahVx/eMtbQ4981kAZY0oOiP5IJLjzXhG9gk6
         rFlYMej0KMbTerV1wrK21/ZJNhLOnWQhGIHe6fz7mFRlSy/QFu9/hLtPI1BxHKX+HINf
         IuJWPYgKMNmFiAiTUAAq5GowSZh6oX2/V8/p/MlCBZ9GFw8CCCpJGfg1cCOOQR6wjEDN
         obx8xaykegDxeSz42u9xJEP+kox7sVClpLiFMa8YD2hC0b1dEZAB5/Hc/6KiwnwoUeL6
         okfw==
X-Forwarded-Encrypted: i=1; AJvYcCVAKNNqve06lFj4Hb/MzKei5Annrp6Mak0NSnX+P4uLuZ3nYf82mzvxSJw2X/0jBS+aYK8uGiZx7lS5IMx7CxR6nRtxHFRslXJ9fibt
X-Gm-Message-State: AOJu0YwnH0UACe+9DwwsxGfgR8G8KT4xYOj/lYPuylE7EllxVOip9xk2
	ZcxntIHeGCPtI5QiuGOOyfzikXJaKIWhnbqgXiW4VmCvFMcoG0uY8xGdQWtJ4g6p+/ZK1GPvKnV
	rAAx4d/ML90yNCJD3/E8mjL+rMDbqec+GWlSz
X-Google-Smtp-Source: AGHT+IFgdSyQXDeCUVnvsTnCVDQKPFyFEiIEFNjsUZk/tofwfYbEg+HsOrs49U/TvQZCb+rEiPokGRFChuLdQ3/vG4M=
X-Received: by 2002:a05:622a:228f:b0:447:daca:4b25 with SMTP id
 d75a77b69052e-44f83aae05bmr2569851cf.28.1721205437062; Wed, 17 Jul 2024
 01:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407091001.1250ad4a-oliver.sang@intel.com> <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
In-Reply-To: <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 17 Jul 2024 02:36:37 -0600
Message-ID: <CAOUHufYvCeiGGa+3PbPDfFx__aV2XxyS7TMHMicws4aNTg4qmQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
To: Janosch Frank <frankja@linux.ibm.com>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Frank van der Linden <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Marc Hartmayer <mhartmay@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000aa9733061d6d5e40"

--000000000000aa9733061d6d5e40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janosch and Oliver,

On Wed, Jul 17, 2024 at 1:57=E2=80=AFAM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> On 7/9/24 07:11, kernel test robot wrote:
> > Hello,
> >
> > kernel test robot noticed a -34.3% regression of vm-scalability.through=
put on:
> >
> >
> > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: =
fix race with speculative PFN walkers")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf517599=
9955b233]
> >
> This has hit s390 huge page backed KVM guests as well.
> Our simple start/stop test case went from ~5 to over 50 seconds of runtim=
e.

Could you try the attached patch please? Thank you.

--000000000000aa9733061d6d5e40
Content-Type: application/octet-stream; name="hugetlb-fix.patch"
Content-Disposition: attachment; filename="hugetlb-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lypl92k50>
X-Attachment-Id: f_lypl92k50

ZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGJfdm1lbW1hcC5jIGIvbW0vaHVnZXRsYl92bWVtbWFwLmMK
aW5kZXggODE5MzkwNjUxNWM2Li45ZTZmYzRjZThkMmIgMTAwNjQ0Ci0tLSBhL21tL2h1Z2V0bGJf
dm1lbW1hcC5jCisrKyBiL21tL2h1Z2V0bGJfdm1lbW1hcC5jCkBAIC00Myw2ICs0Myw4IEBAIHN0
cnVjdCB2bWVtbWFwX3JlbWFwX3dhbGsgewogI2RlZmluZSBWTUVNTUFQX1NQTElUX05PX1RMQl9G
TFVTSAlCSVQoMCkKIC8qIFNraXAgdGhlIFRMQiBmbHVzaCB3aGVuIHdlIHJlbWFwIHRoZSBQVEUg
Ki8KICNkZWZpbmUgVk1FTU1BUF9SRU1BUF9OT19UTEJfRkxVU0gJQklUKDEpCisvKiBzeW5jaHJv
bml6ZV9yY3UoKSB0byBhdm9pZCB3cml0ZXMgZnJvbSBwYWdlX3JlZl9hZGRfdW5sZXNzKCkgKi8K
KyNkZWZpbmUgVk1FTU1BUF9TWU5DSFJPTklaRV9SQ1UJCUJJVCgyKQogCXVuc2lnbmVkIGxvbmcJ
CWZsYWdzOwogfTsKIApAQCAtNDUxLDYgKzQ1Myw5IEBAIHN0YXRpYyBpbnQgX19odWdldGxiX3Zt
ZW1tYXBfcmVzdG9yZV9mb2xpbyhjb25zdCBzdHJ1Y3QgaHN0YXRlICpoLAogCWlmICghZm9saW9f
dGVzdF9odWdldGxiX3ZtZW1tYXBfb3B0aW1pemVkKGZvbGlvKSkKIAkJcmV0dXJuIDA7CiAKKwlp
ZiAoZmxhZ3MgJiBWTUVNTUFQX1NZTkNIUk9OSVpFX1JDVSkKKwkJc3luY2hyb25pemVfcmN1KCk7
CisKIAl2bWVtbWFwX2VuZAk9IHZtZW1tYXBfc3RhcnQgKyBodWdldGxiX3ZtZW1tYXBfc2l6ZSho
KTsKIAl2bWVtbWFwX3JldXNlCT0gdm1lbW1hcF9zdGFydDsKIAl2bWVtbWFwX3N0YXJ0CSs9IEhV
R0VUTEJfVk1FTU1BUF9SRVNFUlZFX1NJWkU7CkBAIC00ODMsMTAgKzQ4OCw3IEBAIHN0YXRpYyBp
bnQgX19odWdldGxiX3ZtZW1tYXBfcmVzdG9yZV9mb2xpbyhjb25zdCBzdHJ1Y3QgaHN0YXRlICpo
LAogICovCiBpbnQgaHVnZXRsYl92bWVtbWFwX3Jlc3RvcmVfZm9saW8oY29uc3Qgc3RydWN0IGhz
dGF0ZSAqaCwgc3RydWN0IGZvbGlvICpmb2xpbykKIHsKLQkvKiBhdm9pZCB3cml0ZXMgZnJvbSBw
YWdlX3JlZl9hZGRfdW5sZXNzKCkgd2hpbGUgdW5mb2xkaW5nIHZtZW1tYXAgKi8KLQlzeW5jaHJv
bml6ZV9yY3UoKTsKLQotCXJldHVybiBfX2h1Z2V0bGJfdm1lbW1hcF9yZXN0b3JlX2ZvbGlvKGgs
IGZvbGlvLCAwKTsKKwlyZXR1cm4gX19odWdldGxiX3ZtZW1tYXBfcmVzdG9yZV9mb2xpbyhoLCBm
b2xpbywgVk1FTU1BUF9TWU5DSFJPTklaRV9SQ1UpOwogfQogCiAvKioKQEAgLTUwOSwxNCArNTEx
LDEzIEBAIGxvbmcgaHVnZXRsYl92bWVtbWFwX3Jlc3RvcmVfZm9saW9zKGNvbnN0IHN0cnVjdCBo
c3RhdGUgKmgsCiAJc3RydWN0IGZvbGlvICpmb2xpbywgKnRfZm9saW87CiAJbG9uZyByZXN0b3Jl
ZCA9IDA7CiAJbG9uZyByZXQgPSAwOwotCi0JLyogYXZvaWQgd3JpdGVzIGZyb20gcGFnZV9yZWZf
YWRkX3VubGVzcygpIHdoaWxlIHVuZm9sZGluZyB2bWVtbWFwICovCi0Jc3luY2hyb25pemVfcmN1
KCk7CisJdW5zaWduZWQgbG9uZyBmbGFncyA9IFZNRU1NQVBfUkVNQVBfTk9fVExCX0ZMVVNIIHwg
Vk1FTU1BUF9TWU5DSFJPTklaRV9SQ1U7CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZm9s
aW8sIHRfZm9saW8sIGZvbGlvX2xpc3QsIGxydSkgewogCQlpZiAoZm9saW9fdGVzdF9odWdldGxi
X3ZtZW1tYXBfb3B0aW1pemVkKGZvbGlvKSkgewotCQkJcmV0ID0gX19odWdldGxiX3ZtZW1tYXBf
cmVzdG9yZV9mb2xpbyhoLCBmb2xpbywKLQkJCQkJCQkgICAgICBWTUVNTUFQX1JFTUFQX05PX1RM
Ql9GTFVTSCk7CisJCQlyZXQgPSBfX2h1Z2V0bGJfdm1lbW1hcF9yZXN0b3JlX2ZvbGlvKGgsIGZv
bGlvLCBmbGFncyk7CisJCQlmbGFncyAmPSBWTUVNTUFQX1NZTkNIUk9OSVpFX1JDVTsKKwogCQkJ
aWYgKHJldCkKIAkJCQlicmVhazsKIAkJCXJlc3RvcmVkKys7CkBAIC01NjQsNiArNTY1LDkgQEAg
c3RhdGljIGludCBfX2h1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6ZV9mb2xpbyhjb25zdCBzdHJ1Y3Qg
aHN0YXRlICpoLAogCQlyZXR1cm4gcmV0OwogCiAJc3RhdGljX2JyYW5jaF9pbmMoJmh1Z2V0bGJf
b3B0aW1pemVfdm1lbW1hcF9rZXkpOworCisJaWYgKGZsYWdzICYgVk1FTU1BUF9TWU5DSFJPTkla
RV9SQ1UpCisJCXN5bmNocm9uaXplX3JjdSgpOwogCS8qCiAJICogVmVyeSBTdWJ0bGUKIAkgKiBJ
ZiBWTUVNTUFQX1JFTUFQX05PX1RMQl9GTFVTSCBpcyBzZXQsIFRMQiBmbHVzaGluZyBpcyBub3Qg
cGVyZm9ybWVkCkBAIC02MTEsMTAgKzYxNSw3IEBAIHZvaWQgaHVnZXRsYl92bWVtbWFwX29wdGlt
aXplX2ZvbGlvKGNvbnN0IHN0cnVjdCBoc3RhdGUgKmgsIHN0cnVjdCBmb2xpbyAqZm9saW8pCiB7
CiAJTElTVF9IRUFEKHZtZW1tYXBfcGFnZXMpOwogCi0JLyogYXZvaWQgd3JpdGVzIGZyb20gcGFn
ZV9yZWZfYWRkX3VubGVzcygpIHdoaWxlIGZvbGRpbmcgdm1lbW1hcCAqLwotCXN5bmNocm9uaXpl
X3JjdSgpOwotCi0JX19odWdldGxiX3ZtZW1tYXBfb3B0aW1pemVfZm9saW8oaCwgZm9saW8sICZ2
bWVtbWFwX3BhZ2VzLCAwKTsKKwlfX2h1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6ZV9mb2xpbyhoLCBm
b2xpbywgJnZtZW1tYXBfcGFnZXMsIFZNRU1NQVBfU1lOQ0hST05JWkVfUkNVKTsKIAlmcmVlX3Zt
ZW1tYXBfcGFnZV9saXN0KCZ2bWVtbWFwX3BhZ2VzKTsKIH0KIApAQCAtNjQxLDYgKzY0Miw3IEBA
IHZvaWQgaHVnZXRsYl92bWVtbWFwX29wdGltaXplX2ZvbGlvcyhzdHJ1Y3QgaHN0YXRlICpoLCBz
dHJ1Y3QgbGlzdF9oZWFkICpmb2xpb19sCiB7CiAJc3RydWN0IGZvbGlvICpmb2xpbzsKIAlMSVNU
X0hFQUQodm1lbW1hcF9wYWdlcyk7CisJdW5zaWduZWQgbG9uZyBmbGFncyA9IFZNRU1NQVBfUkVN
QVBfTk9fVExCX0ZMVVNIIHwgVk1FTU1BUF9TWU5DSFJPTklaRV9SQ1U7CiAKIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGZvbGlvLCBmb2xpb19saXN0LCBscnUpIHsKIAkJaW50IHJldCA9IGh1Z2V0bGJf
dm1lbW1hcF9zcGxpdF9mb2xpbyhoLCBmb2xpbyk7CkBAIC02NTcsMTQgKzY1OSwxMSBAQCB2b2lk
IGh1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6ZV9mb2xpb3Moc3RydWN0IGhzdGF0ZSAqaCwgc3RydWN0
IGxpc3RfaGVhZCAqZm9saW9fbAogCiAJZmx1c2hfdGxiX2FsbCgpOwogCi0JLyogYXZvaWQgd3Jp
dGVzIGZyb20gcGFnZV9yZWZfYWRkX3VubGVzcygpIHdoaWxlIGZvbGRpbmcgdm1lbW1hcCAqLwot
CXN5bmNocm9uaXplX3JjdSgpOwotCiAJbGlzdF9mb3JfZWFjaF9lbnRyeShmb2xpbywgZm9saW9f
bGlzdCwgbHJ1KSB7CiAJCWludCByZXQ7CiAKLQkJcmV0ID0gX19odWdldGxiX3ZtZW1tYXBfb3B0
aW1pemVfZm9saW8oaCwgZm9saW8sICZ2bWVtbWFwX3BhZ2VzLAotCQkJCQkJICAgICAgIFZNRU1N
QVBfUkVNQVBfTk9fVExCX0ZMVVNIKTsKKwkJcmV0ID0gX19odWdldGxiX3ZtZW1tYXBfb3B0aW1p
emVfZm9saW8oaCwgZm9saW8sICZ2bWVtbWFwX3BhZ2VzLCBmbGFncyk7CisJCWZsYWdzICY9IH5W
TUVNTUFQX1NZTkNIUk9OSVpFX1JDVTsKIAogCQkvKgogCQkgKiBQYWdlcyB0byBiZSBmcmVlZCBt
YXkgaGF2ZSBiZWVuIGFjY3VtdWxhdGVkLiAgSWYgd2UKQEAgLTY3OCw4ICs2NzcsNyBAQCB2b2lk
IGh1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6ZV9mb2xpb3Moc3RydWN0IGhzdGF0ZSAqaCwgc3RydWN0
IGxpc3RfaGVhZCAqZm9saW9fbAogCQkJZmx1c2hfdGxiX2FsbCgpOwogCQkJZnJlZV92bWVtbWFw
X3BhZ2VfbGlzdCgmdm1lbW1hcF9wYWdlcyk7CiAJCQlJTklUX0xJU1RfSEVBRCgmdm1lbW1hcF9w
YWdlcyk7Ci0JCQlfX2h1Z2V0bGJfdm1lbW1hcF9vcHRpbWl6ZV9mb2xpbyhoLCBmb2xpbywgJnZt
ZW1tYXBfcGFnZXMsCi0JCQkJCQkJIFZNRU1NQVBfUkVNQVBfTk9fVExCX0ZMVVNIKTsKKwkJCV9f
aHVnZXRsYl92bWVtbWFwX29wdGltaXplX2ZvbGlvKGgsIGZvbGlvLCAmdm1lbW1hcF9wYWdlcywg
ZmxhZ3MpOwogCQl9CiAJfQogCg==
--000000000000aa9733061d6d5e40--

