Return-Path: <linux-kernel+bounces-345558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090898B779
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BED5B246BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038419F415;
	Tue,  1 Oct 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJVf/e2u"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F719F125
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772304; cv=none; b=FT2hCqFts5zEOzvDsRc4sVoAy+4VJz3i+TVz94bYANMTRtdmSJGTccytF5fl1DNUoQhFyelo7EV58iaBWpiynwikD/NMT3wMBP1s1lSYAqWco54MLDEkFj9EnIGOYXe9cf6JaAUqoWliylHjlm38oqgSSeKotuC3+P+U8AwAMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772304; c=relaxed/simple;
	bh=ViV/raMMu3yD1LhUeCZWEBjK1/2Ry+eUVdO9uFToxSw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IxrwDwvIaUshzlXNDbkTFy7gwReeC5trPx2M9+yjMiDstDxDi3DPeKUcgz97Zx7bIhJlsuEhLgQW50ky3/VpK2wq+JK3EDFCqNCVMMhl/9ElTThCKgUPGcni3/Lj3wK7H2VbsOygtdoPGYfAkUH/x68ouvrXLvNb+cPLNo3jhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJVf/e2u; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277ef9a4d11so2177531fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727772301; x=1728377101; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ViV/raMMu3yD1LhUeCZWEBjK1/2Ry+eUVdO9uFToxSw=;
        b=ZJVf/e2u6MEiTGqaJqljvrQqIUeU2tD/Zgt1E5ufutbMUDGsfJtQxt79hcmG9GOwQy
         RCNilVRtbTXYMEUoLAdjC5tGJez87G6mYwYzhSmrB0EFFiR3aTzsKTbi77Ccx8l+bctq
         PuQHkTphppv4sN6Iyf1yLSvH7oUvkfIRCm9iT/pqpUyy6H9Ow/JfTitRLOUGJ62XptEt
         FPuwLE+v99v/Vvn6khVNS2uf+juv+z4pOzatUWn6jMIACREIromcwAI7InkAFsJ292lA
         OuhkhiU3oucqmiPHeYRph9YC/j7KM/1G4IB4+qixH0gl94/sjFuqqwEF3uFdELQW0O7E
         02Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772301; x=1728377101;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViV/raMMu3yD1LhUeCZWEBjK1/2Ry+eUVdO9uFToxSw=;
        b=lYzJpE185fWK21f+KzhghJntIZoe/V9FM79OeinR3uHooD4SxgtmH4WFcgpce6oLuc
         UmFvt8RYijFthLhz8yiDQf59kGMpZ+l+xUZf0rii4LpxPL7VJueeIYTgcSJOb6DpH33L
         8JtmFburknYCkIw5gB+jStUmFSqHBIaPWSL37/xQq+jFEDuldd4eSz4P19xU2DN/uEcs
         KY35AoY9SrTah7/U1BX8mH/8qy9Bw2heswaiqfW6Si/celw3Bvo4epXF4lfkTFCvrGBD
         6BlXx/PMVIq6LGJDkhS1Lme2946bUUDcmQujTspBE5dfqFhY1tkx9lQe+cYoKqLny1Lp
         8pXg==
X-Gm-Message-State: AOJu0YwPFWYTibToAjpqey9Lo+6GnMS1R1gVNTAHInFi7KlGbI1T1leb
	CxiURfY14ItMbgTJMzHQqQa6WiR8bYj07Kkaa7FfXVDa5muFaj7Ul9DFUeR/M2Xj8yALn99kwmm
	R1wjPPzfiRn7MHtCjzY9/HdIQ9K5sYpqEsvU=
X-Google-Smtp-Source: AGHT+IGY7Pa9Komax3nwquuNten4KjpBIRsXOLQkkLeZUOYv09H9jgmLHSEPOJwHj/fk96PnxnampcCCTZsvQ2Uyt1U=
X-Received: by 2002:a05:6870:c18d:b0:267:df02:f7c0 with SMTP id
 586e51a60fabf-28710bd1115mr8560140fac.33.1727772301347; Tue, 01 Oct 2024
 01:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Helos <i.use.arch.btw.00111@gmail.com>
Date: Tue, 1 Oct 2024 10:44:50 +0200
Message-ID: <CAGqW2aieyR94Cuhstxb+DoyQfmhhbgYwCxYYDr+QUhJgXzuNKQ@mail.gmail.com>
Subject: [Patch] Minor changes to pr_emerg lines in file: panic.c
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000466df306236656c8"

--000000000000466df306236656c8
Content-Type: multipart/alternative; boundary="000000000000466df306236656c6"

--000000000000466df306236656c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Patch] Minor changes to pr_emerg lines in file: panic.c

This patch includes minor modifications at lines 348, 424, and 457 of file
kernel/panic.c (pr_emerg lines)
They are just a visual changes that are meant to improve noticeability of
pr_emerg lines on the screen during kernel panic. No kernel panic logic has
been altered.

The patch is related to the PR:
https://github.com/torvalds/linux/pull/968/commits/df766d8eb601bd453dd1573d=
b21b394d4de3083d
.

I would greatly appreciate it if you could review this patch and provide
any feedback. I look forward to your response regarding the decision on
this patch, either as a response to this email or a comment to the PR.

Best regards,
Ro=C5=9Bcis=C5=82aw Szyma=C5=84ski (i.use.arch.btw.00111@gmail.com)

P.S
I want to apologize for not using *git send-email* to sending this email. I
have encountered skill issues when trying to use it. I hope it did not
cause any problems.

--000000000000466df306236656c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[Patch] Minor changes to pr_emerg lines in file: panic.c<b=
r><br>This patch includes minor modifications at lines 348, 424, and 457 of=
 file kernel/panic.c (pr_emerg lines)<br>They are just a visual changes tha=
t are meant to improve noticeability of pr_emerg lines on the screen during=
 kernel panic. No kernel panic logic has been altered.<br><br>The patch is =
related to the PR: <a href=3D"https://github.com/torvalds/linux/pull/968/co=
mmits/df766d8eb601bd453dd1573db21b394d4de3083d">https://github.com/torvalds=
/linux/pull/968/commits/df766d8eb601bd453dd1573db21b394d4de3083d</a> .<br><=
br>I would greatly appreciate it if you could review this patch and provide=
 any feedback. I look forward to your response regarding the decision on th=
is patch, either as a response to this email or a comment to the PR.<br><br=
>Best regards,<br><div>Ro=C5=9Bcis=C5=82aw Szyma=C5=84ski (<a href=3D"mailt=
o:i.use.arch.btw.00111@gmail.com">i.use.arch.btw.00111@gmail.com</a>)</div>=
<div><br></div><div>P.S</div><div>I want to apologize for not using <b>git =
send-email</b> to sending this email. I have encountered skill issues when =
trying to use it. I hope it did not cause any problems.<br></div></div>

--000000000000466df306236656c6--
--000000000000466df306236656c8
Content-Type: text/x-patch; charset="US-ASCII"; name="panic-pr_emerg-update.patch"
Content-Disposition: attachment; filename="panic-pr_emerg-update.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1q6sn1x0>
X-Attachment-Id: f_m1q6sn1x0

RnJvbSBkZjc2NmQ4ZWI2MDFiZDQ1M2RkMTU3M2RiMjFiMzk0ZDRkZTMwODNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Um89QzU9OUJjaXM9QzU9ODJhdz0yMFN6eW1h
PUM1PTg0c2tpPz0KIDwxNTYyMzcxNjQrSS11c2UtQXJjaC1idHctMDAxMTFAdXNlcnMubm9yZXBs
eS5naXRodWIuY29tPgpEYXRlOiBUdWUsIDEgT2N0IDIwMjQgMDk6Mzc6MjQgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBNaW5vciBjaGFuZ2VzIHRvIHByX2VtZXJnIGxpbmVzIGluIGZpbGU6IHBhbmlj
LmMKCkNoYW5nZXMgYXQgbGluZXMgMzQ4LCA0MjQsIGFuZCA0NTcuCi0tLQoga2VybmVsL3Bhbmlj
LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvcGFuaWMuYyBiL2tlcm5lbC9wYW5pYy5jCmluZGV4
IGZiYzU5YjNiNjRkMGI1Li4xOTkzNDVlYjM2OWZhMCAxMDA2NDQKLS0tIGEva2VybmVsL3Bhbmlj
LmMKKysrIGIva2VybmVsL3BhbmljLmMKQEAgLTM0NSw3ICszNDUsNyBAQCB2b2lkIHBhbmljKGNv
bnN0IGNoYXIgKmZtdCwgLi4uKQogCWlmIChsZW4gJiYgYnVmW2xlbiAtIDFdID09ICdcbicpCiAJ
CWJ1ZltsZW4gLSAxXSA9ICdcMCc7CiAKLQlwcl9lbWVyZygiS2VybmVsIHBhbmljIC0gbm90IHN5
bmNpbmc6ICVzXG4iLCBidWYpOworCXByX2VtZXJnKCJLRVJORUwgUEFOSUMgLSBub3Qgc3luY2lu
ZzogJXNcbiIsIGJ1Zik7CiAjaWZkZWYgQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0UKIAkvKgogCSAq
IEF2b2lkIG5lc3RlZCBzdGFjay1kdW1waW5nIGlmIGEgcGFuaWMgb2NjdXJzIGR1cmluZyBvb3Bz
IHByb2Nlc3NpbmcKQEAgLTQyMSw3ICs0MjEsNyBAQCB2b2lkIHBhbmljKGNvbnN0IGNoYXIgKmZt
dCwgLi4uKQogCQkgKiBEZWxheSB0aW1lb3V0IHNlY29uZHMgYmVmb3JlIHJlYm9vdGluZyB0aGUg
bWFjaGluZS4KIAkJICogV2UgY2FuJ3QgdXNlIHRoZSAibm9ybWFsIiB0aW1lcnMgc2luY2Ugd2Ug
anVzdCBwYW5pY2tlZC4KIAkJICovCi0JCXByX2VtZXJnKCJSZWJvb3RpbmcgaW4gJWQgc2Vjb25k
cy4uXG4iLCBwYW5pY190aW1lb3V0KTsKKwkJcHJfZW1lcmcoIkF0dGVtcHRpbmcgYW4gRU1FUkdF
TkNZIFJFQk9PVCBpbiAlZCBzZWNvbmRzLi5cbiIsIHBhbmljX3RpbWVvdXQpOwogCiAJCWZvciAo
aSA9IDA7IGkgPCBwYW5pY190aW1lb3V0ICogMTAwMDsgaSArPSBQQU5JQ19USU1FUl9TVEVQKSB7
CiAJCQl0b3VjaF9ubWlfd2F0Y2hkb2coKTsKQEAgLTQ1NCw3ICs0NTQsNyBAQCB2b2lkIHBhbmlj
KGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogI2lmIGRlZmluZWQoQ09ORklHX1MzOTApCiAJZGlzYWJs
ZWRfd2FpdCgpOwogI2VuZGlmCi0JcHJfZW1lcmcoIi0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5v
dCBzeW5jaW5nOiAlcyBdLS0tXG4iLCBidWYpOworCXByX2VtZXJnKCItLS08IGVuZCBLRVJORUwg
UEFOSUMgLSBub3Qgc3luY2luZzogJXMgPi0tLVxuIiwgYnVmKTsKIAogCS8qIERvIG5vdCBzY3Jv
bGwgaW1wb3J0YW50IG1lc3NhZ2VzIHByaW50ZWQgYWJvdmUgKi8KIAlzdXBwcmVzc19wcmludGsg
PSAxOwo=
--000000000000466df306236656c8--

