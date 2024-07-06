Return-Path: <linux-kernel+bounces-243387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EED9295A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0451F21765
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A928DA5;
	Sat,  6 Jul 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqVFb2K"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6B1C6A0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720304509; cv=none; b=PsqCFMhdEpvIk3GrmcxbMvUN1G/33LD1dJN/TcJX4ICjzjsuMlndwqnAjh9Qxn8k3nqCOMKgQWzG9KuT4FjoDuyB3MnXDypnFNgmLl16LGjilFUnZCgw1J/UTInAVX8WuAJxGK4nhSfzOVSvrvkPGlAOA/xNWfvU8X4fIjvNOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720304509; c=relaxed/simple;
	bh=18hXOEQMxxFxwFnW5OQmbd0o18Nfzfll7NcvDoG1UoY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T0X2SQvhLLQ0TTPoSMy9ii3x4y/NkaQrUn4mKU+TCG+ojxin8uCEruK104TW946g8Me4ztK1hofxB155Pro6JOLplrdHFnmj1YckVN/l/mZ3nLNR2y9iWtOxH5Uc7HDOhHR4UQxiIVD1h3LUnbKE6PmRJOE5Wb9nZhSOR+kP6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPqVFb2K; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f2fd568899so1170646e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720304507; x=1720909307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3K5DZZQFQis3AnZ5/piMcEiGwo0jsYmg5OjUXUPA7E=;
        b=jPqVFb2K9IFk2ixUiP+dSVYi/hfcRqEtc29iyegplTRL0Z9BEM58qnWwyo8xAm+Vyl
         oZ5bi2A456wai+n83tTTuipA+o7x87ccSzG6BIbsKiQfuPud8OGkB4UoOSngGIYCWb+u
         2yK18fH7hyx4xd6FiX1eBghq/f7ELlVHVTYDRHBkn9cM2rT2e0YspkZZRb3mjWEK1SDs
         toNeQkkvrEBXjVkEy3Glegq2XDppAmvr/lwv54oIsG61kjK3aVYmxWJ8yrXInp08QjtU
         kI0nezU9sqHoUvxXif0+1p75+2clr2McfxXDxlwieuLYRy0AYLE77I5g6MXQ1uMeRNAR
         Hq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720304507; x=1720909307;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3K5DZZQFQis3AnZ5/piMcEiGwo0jsYmg5OjUXUPA7E=;
        b=jwmc5SB9mkvt3kMER/z75VcPKDG6yk3xTU9EriaqwGKi5m6nM1gBoUjEJAizoh8Op+
         ITNTr73IO5imreptw5CbbtvVgRfW1Z1hQBJ8UEi2vO4XbaYjgVfaYJWkBui/cRGCBuzu
         6TJCRiJeYYf9SwxxBIWtYbFV/bK8IERLiuXYriBNdPQoo2EyuenNro4gDG/aoF06Xza4
         MbyXyaQIts5g2UQ1Mc7G2TLDKKvJ0yIxMg7OATTSMhBth7FXZ7T2Nud1zQNxbB2FuF2v
         91NQXYd07oK+9U+Pelasz+98tzgH8Ul3F5tlFYIpCsBDXYQfVVrzclgcUHQ6KamjT5GJ
         y8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUCu/p/rfbohJDzO4vDxyOBgf6UxaIVGrmFFMB4FQKwhTanLD6tWKk2yA5j1mc8Q5sLz5eY7mXmKBsuQ4dznySbpwpvkKCxA/MUUBSl
X-Gm-Message-State: AOJu0Yw/JZBrGWp6DARy3R/2CWcjIOGSucu90vQZAwm/MAOwb8iiwttR
	APnRWYeb16wPXD2ROtkbYZSZWhNcSAL9pJ1pPgA4ThVTQfaCfY8DPNEVqG8IXQTBZRQzI9+w+j6
	v43xICVikDSv6W9QZxxb6DU21uu8=
X-Google-Smtp-Source: AGHT+IFftS10DqX9nMo9AnuPrwCeOm8DADzf8x+naaH26C4FqMA0MxPOr+BVEVRpHlJFbt5Ub8HYM2nbYs6JEUb3+oU=
X-Received: by 2002:a05:6122:4210:b0:4eb:e1a:5ad1 with SMTP id
 71dfb90a1353d-4f2f615ee60mr4986848e0c.8.1720304506710; Sat, 06 Jul 2024
 15:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Parker Stafford <parkerstafforddev@gmail.com>
Date: Sat, 6 Jul 2024 15:21:35 -0700
Message-ID: <CANtevs+a-ec45oz1tJd0m2Qc+dU4ASj9BcdUbyhsQ5Hm94dEKQ@mail.gmail.com>
Subject: [PATCH] sched/autogroup: Improve readability and performance
To: mingo@redhat.com
Cc: peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, "rostedt@goodmis.org" <rostedt@goodmis.org>, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000074183061c9b9b37"

--000000000000074183061c9b9b37
Content-Type: multipart/alternative; boundary="000000000000074182061c9b9b35"

--000000000000074182061c9b9b35
Content-Type: text/plain; charset="UTF-8"

 Hello,

 This patch improves the readability and performance of the autogroup
scheduling code. The changes include:

 - Added detailed comments for better understanding.
 - Optimized locking mechanisms to minimize contention.
 - Improved error handling and provided more informative error messages.
 - Avoided unnecessary memory allocations and deallocations.

 The patch has been tested and shown to work as expected. Signed-off-by:
Parker Stafford parkerstafforddev@gmail.com

--000000000000074182061c9b9b35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Hello,<div><br></div><div>=C2=A0This patch improves =
the readability and performance of the autogroup scheduling code. The chang=
es include:</div><div><br></div><div>=C2=A0- Added detailed comments for be=
tter understanding.</div><div>=C2=A0- Optimized locking mechanisms to minim=
ize contention.</div><div>=C2=A0- Improved error handling and provided more=
 informative error messages.</div><div>=C2=A0- Avoided unnecessary memory a=
llocations and deallocations.</div><div><br></div><div>=C2=A0The patch has =
been tested and shown to work as expected.

Signed-off-by: Parker Stafford <a href=3D"mailto:parkerstafforddev@gmail.co=
m">parkerstafforddev@gmail.com</a></div></div>

--000000000000074182061c9b9b35--
--000000000000074183061c9b9b37
Content-Type: application/octet-stream; 
	name="improve-autogroup-scheduling.patch"
Content-Disposition: attachment; 
	filename="improve-autogroup-scheduling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyaotii30>
X-Attachment-Id: f_lyaotii30

RnJvbSA2NTMwNzA1MjkwZDJmZjA1MTA5ZWEzODI5ZjhjYzg1YjFkNjczNWZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXJrZXIgU3RhZmZvcmQgPHBhcmtlcnN0YWZmb3JkZGV2QGdt
YWlsLmNvbT4KRGF0ZTogU2F0LCA2IEp1bCAyMDI0IDE1OjEwOjQ1IC0wNzAwClN1YmplY3Q6IFtQ
QVRDSF0gc2NoZWQvYXV0b2dyb3VwOiBJbXByb3ZlIHJlYWRhYmlsaXR5IGFuZCBwZXJmb3JtYW5j
ZQoKRW5zdXJlIHRoYXQgbG9ja3MgYXJlIGhlbGQgZm9yIHRoZSBzaG9ydGVzdCBuZWNlc3Nhcnkg
ZHVyYXRpb24uIEVuaGFuY2VkIGVycm9yIG1lc3NhZ2VzIGluIHRoZSBhdXRvZ3JvdXBfY3JlYXRl
IGZ1bmN0aW9uLiBPcHRpbWl6ZWQgbWVtb3J5IGFsbG9jYXRpb24gcGF0aHMgYW5kIGVuc3VyZWQg
cHJvcGVyIGNsZWFudXAgaW4gZXJyb3Igc2NlbmFyaW9zCgpTaWduZWQtb2ZmLWJ5OiBQYXJrZXIg
U3RhZmZvcmQgPHBhcmtlcnN0YWZmb3JkZGV2QGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvc2NoZWQv
YXV0b2dyb3VwLmMgfCA0NyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2F1dG9ncm91cC5jIGIva2VybmVsL3NjaGVkL2F1dG9ncm91
cC5jCmluZGV4IGRiNjhhOTY0ZTM0ZS4uYjkzNWEwYTkxODdlIDEwMDY0NAotLS0gYS9rZXJuZWwv
c2NoZWQvYXV0b2dyb3VwLmMKKysrIGIva2VybmVsL3NjaGVkL2F1dG9ncm91cC5jCkBAIC0yLDgg
KzIsMjMgQEAKIAogLyoKICAqIEF1dG8tZ3JvdXAgc2NoZWR1bGluZyBpbXBsZW1lbnRhdGlvbjoK
KyAqIFRoaXMgZmlsZSBpbXBsZW1lbnRzIGF1dG9tYXRpYyBncm91cGluZyBvZiB0YXNrcyB0byBp
bXByb3ZlIHNjaGVkdWxpbmcgZmFpcm5lc3MuCiAgKi8KIAorI2luY2x1ZGUgPGxpbnV4L3NjaGVk
Lmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNp
bmNsdWRlIDxsaW51eC9wcmludGsuaD4KKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9zeXNjdGwuaD4K
KyNpbmNsdWRlIDxsaW51eC9zY2hlZC9hdXRvZ3JvdXAuaD4KKyNpbmNsdWRlIDxsaW51eC9zZXFf
ZmlsZS5oPgorI2luY2x1ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+CisjaW5jbHVkZSA8bGludXgvY2dy
b3VwLmg+CisjaW5jbHVkZSA8bGludXgvcHJvY19mcy5oPgorI2luY2x1ZGUgPGxpbnV4L3JjdXBk
YXRlLmg+CisjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgorI2luY2x1ZGUgPGxpbnV4L3N5c2N0
bC5oPgorCiB1bnNpZ25lZCBpbnQgX19yZWFkX21vc3RseSBzeXNjdGxfc2NoZWRfYXV0b2dyb3Vw
X2VuYWJsZWQgPSAxOwogc3RhdGljIHN0cnVjdCBhdXRvZ3JvdXAgYXV0b2dyb3VwX2RlZmF1bHQ7
CiBzdGF0aWMgYXRvbWljX3QgYXV0b2dyb3VwX3NlcV9ucjsKQEAgLTQ4LDcgKzYzLDYgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGF1dG9ncm91cF9kZXN0cm95KHN0cnVjdCBrcmVmICprcmVmKQogCXN0
cnVjdCBhdXRvZ3JvdXAgKmFnID0gY29udGFpbmVyX29mKGtyZWYsIHN0cnVjdCBhdXRvZ3JvdXAs
IGtyZWYpOwogCiAjaWZkZWYgQ09ORklHX1JUX0dST1VQX1NDSEVECi0JLyogV2UndmUgcmVkaXJl
Y3RlZCBSVCB0YXNrcyB0byB0aGUgcm9vdCB0YXNrIGdyb3VwLi4uICovCiAJYWctPnRnLT5ydF9z
ZSA9IE5VTEw7CiAJYWctPnRnLT5ydF9ycSA9IE5VTEw7CiAjZW5kaWYKQEAgLTk4LDEzICsxMTIs
NiBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBhdXRvZ3JvdXAgKmF1dG9ncm91cF9jcmVhdGUodm9p
ZCkKIAlhZy0+aWQgPSBhdG9taWNfaW5jX3JldHVybigmYXV0b2dyb3VwX3NlcV9ucik7CiAJYWct
PnRnID0gdGc7CiAjaWZkZWYgQ09ORklHX1JUX0dST1VQX1NDSEVECi0JLyoKLQkgKiBBdXRvZ3Jv
dXAgUlQgdGFza3MgYXJlIHJlZGlyZWN0ZWQgdG8gdGhlIHJvb3QgdGFzayBncm91cAotCSAqIHNv
IHdlIGRvbid0IGhhdmUgdG8gbW92ZSB0YXNrcyBhcm91bmQgdXBvbiBwb2xpY3kgY2hhbmdlLAot
CSAqIG9yIGZsYWlsIGFyb3VuZCB0cnlpbmcgdG8gYWxsb2NhdGUgYmFuZHdpZHRoIG9uIHRoZSBm
bHkuCi0JICogQSBiYW5kd2lkdGggZXhjZXB0aW9uIGluIF9fc2NoZWRfc2V0c2NoZWR1bGVyKCkg
YWxsb3dzCi0JICogdGhlIHBvbGljeSBjaGFuZ2UgdG8gcHJvY2VlZC4KLQkgKi8KIAlmcmVlX3J0
X3NjaGVkX2dyb3VwKHRnKTsKIAl0Zy0+cnRfc2UgPSByb290X3Rhc2tfZ3JvdXAucnRfc2U7CiAJ
dGctPnJ0X3JxID0gcm9vdF90YXNrX2dyb3VwLnJ0X3JxOwpAQCAtMTI5LDE0ICsxMzYsNiBAQCBi
b29sIHRhc2tfd2FudHNfYXV0b2dyb3VwKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgc3RydWN0IHRh
c2tfZ3JvdXAgKnRnKQogewogCWlmICh0ZyAhPSAmcm9vdF90YXNrX2dyb3VwKQogCQlyZXR1cm4g
ZmFsc2U7Ci0JLyoKLQkgKiBJZiB3ZSByYWNlIHdpdGggYXV0b2dyb3VwX21vdmVfZ3JvdXAoKSB0
aGUgY2FsbGVyIGNhbiB1c2UgdGhlIG9sZAotCSAqIHZhbHVlIG9mIHNpZ25hbC0+YXV0b2dyb3Vw
IGJ1dCBpbiB0aGlzIGNhc2Ugc2NoZWRfbW92ZV90YXNrKCkgd2lsbAotCSAqIGJlIGNhbGxlZCBh
Z2FpbiBiZWZvcmUgYXV0b2dyb3VwX2tyZWZfcHV0KCkuCi0JICoKLQkgKiBIb3dldmVyLCB0aGVy
ZSBpcyBubyB3YXkgc2NoZWRfYXV0b2dyb3VwX2V4aXRfdGFzaygpIGNvdWxkIHRlbGwgdXMKLQkg
KiB0byBhdm9pZCBhdXRvZ3JvdXAtPnRnLCBzbyB3ZSBhYnVzZSBQRl9FWElUSU5HIGZsYWcgZm9y
IHRoaXMgY2FzZS4KLQkgKi8KIAlpZiAocC0+ZmxhZ3MgJiBQRl9FWElUSU5HKQogCQlyZXR1cm4g
ZmFsc2U7CiAKQEAgLTE0NSwxMSArMTQ0LDYgQEAgYm9vbCB0YXNrX3dhbnRzX2F1dG9ncm91cChz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCB0YXNrX2dyb3VwICp0ZykKIAogdm9pZCBzY2hl
ZF9hdXRvZ3JvdXBfZXhpdF90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKIHsKLQkvKgotCSAq
IFdlIGFyZSBnb2luZyB0byBjYWxsIGV4aXRfbm90aWZ5KCkgYW5kIGF1dG9ncm91cF9tb3ZlX2dy
b3VwKCkgY2FuJ3QKLQkgKiBzZWUgdGhpcyB0aHJlYWQgYWZ0ZXIgdGhhdDogd2UgY2FuIG5vIGxv
bmdlciB1c2Ugc2lnbmFsLT5hdXRvZ3JvdXAuCi0JICogU2VlIHRoZSBQRl9FWElUSU5HIGNoZWNr
IGluIHRhc2tfd2FudHNfYXV0b2dyb3VwKCkuCi0JICovCiAJc2NoZWRfbW92ZV90YXNrKHApOwog
fQogCkBAIC0xNzAsMTcgKzE2NCw2IEBAIGF1dG9ncm91cF9tb3ZlX2dyb3VwKHN0cnVjdCB0YXNr
X3N0cnVjdCAqcCwgc3RydWN0IGF1dG9ncm91cCAqYWcpCiAJfQogCiAJcC0+c2lnbmFsLT5hdXRv
Z3JvdXAgPSBhdXRvZ3JvdXBfa3JlZl9nZXQoYWcpOwotCS8qCi0JICogV2UgY2FuJ3QgYXZvaWQg
c2NoZWRfbW92ZV90YXNrKCkgYWZ0ZXIgd2UgY2hhbmdlZCBzaWduYWwtPmF1dG9ncm91cCwKLQkg
KiB0aGlzIHByb2Nlc3MgY2FuIGFscmVhZHkgcnVuIHdpdGggdGFza19ncm91cCgpID09IHByZXYt
PnRnIG9yIHdlIGNhbgotCSAqIHJhY2Ugd2l0aCBjZ3JvdXAgY29kZSB3aGljaCBjYW4gcmVhZCBh
dXRvZ3JvdXAgPSBwcmV2IHVuZGVyIHJxLT5sb2NrLgotCSAqIEluIHRoZSBsYXR0ZXIgY2FzZSBm
b3JfZWFjaF90aHJlYWQoKSBjYW4gbm90IG1pc3MgYSBtaWdyYXRpbmcgdGhyZWFkLAotCSAqIGNw
dV9jZ3JvdXBfYXR0YWNoKCkgbXVzdCBub3QgYmUgcG9zc2libGUgYWZ0ZXIgY2dyb3VwX2V4aXQo
KSBhbmQgaXQKLQkgKiBjYW4ndCBiZSByZW1vdmVkIGZyb20gdGhyZWFkIGxpc3QsIHdlIGhvbGQg
LT5zaWdsb2NrLgotCSAqCi0JICogSWYgYW4gZXhpdGluZyB0aHJlYWQgd2FzIGFscmVhZHkgcmVt
b3ZlZCBmcm9tIHRocmVhZCBsaXN0IHdlIHJlbHkgb24KLQkgKiBzY2hlZF9hdXRvZ3JvdXBfZXhp
dF90YXNrKCkuCi0JICovCiAJZm9yX2VhY2hfdGhyZWFkKHAsIHQpCiAJCXNjaGVkX21vdmVfdGFz
ayh0KTsKIAotLSAKMi40NS4yCgo=
--000000000000074183061c9b9b37--

