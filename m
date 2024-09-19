Return-Path: <linux-kernel+bounces-333661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713897CBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE31C20D62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975B1A01B9;
	Thu, 19 Sep 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bNZs5mgy"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1B12E4A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761944; cv=none; b=U1mynS0ZaEqRFU9zvzlmzHGYI2yNljyIyA88C/XeK0psSCAjDGOv7vfJ6m5tbJtxtb858/8XR4tIz/+msVD+D+xUZie8cZwPE/JYTL/e1A3uwHqYefcqqmYVSdRbjOMbgI+q+7NpZnfuoXFDre7Zl5aJAoeQFrQd954KaO+h8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761944; c=relaxed/simple;
	bh=YuGyoFlR3zsbYKdnvpdwmpjvDsWB5PPm0aXY6r9+KtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWZuTSjzgl8C7tr6MrPUxfM77Lt0bZqltGkkAJvBOwcxCPL6ZEDxWdLGbmVS7ndKubudJt7G0UcPlwQN2Vv0lH1kf4A2DBYFnLlLGdFOhy2ERcBrpYPARe9XdtbVQLrfjAas3zuQuro+6zObG5rWN8J27IK5ef5gXVHnMqLYu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bNZs5mgy; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03caab48a2so902005276.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726761941; x=1727366741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdUdhIPwwI6AU/7Ra680ydg6oDI8v4ajBh4UcdHCeXo=;
        b=bNZs5mgy9dFzZ/mWanHF1KqJB70V5B0LAtEP1sAdTMW3aXptpIJZJSB+Qpw/bQSG4N
         7Aq7uFC74smuR4bEfrV1O0ith88CgbcXn4Y+jg6qpDIHN7XC2t/Q+dCSO/PdLSYqdC9+
         IVE7UWq2isHST5wsJvQAH2siA/ENdaeQg8vdAk9LijqVXwpWIZoZMXm05QNd32G/vuND
         33LoiOn3WGFCx+ybozZ4Vc7caFMaOpc8lR8dFdy80kDKrFQyRo3voEx0Ajwoh8MFMrRN
         JxwSWve+EJNHZl5+FEfewffqCgVudhO2zpY1BUvS5b5l40KfVhMnZbhkR5N3qFiKLXVm
         Triw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761941; x=1727366741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdUdhIPwwI6AU/7Ra680ydg6oDI8v4ajBh4UcdHCeXo=;
        b=EPYYC4OFPIWWfoCGkiD25DFrynB5lafKXSmtkpwbmHO7iYn8XogUaldOFyNEAWnOrl
         hcqEJarMP4ejKulo5MXl0+HGXS8Qtr1CtwboY3/pYoqGUGULAnifG/Z+mBxQFbanK7kU
         pr4CUwplZEQrzsnnOhfZkNAU0gfa+jYnNh9FayPSjuKAin3Yvie4Uto+0K8St/x6y3w6
         etrlH0TocpHPPR6GcoyzRJa84+lf1AJpkGlhYTlb3RYuzm5DXgrhomaJfNJgoj4UrNSP
         eS3dawgvgY3yPyE1AAPapAs+tf7v/RqgkZw/7FwanYcERtSiD6zgDPnnCzOIKp1I2smI
         381g==
X-Forwarded-Encrypted: i=1; AJvYcCU32ZneQOHj5qKTeL9Sk9LmSoC+J9Gy8nc0W9xDRymgqI1VT0dNF6VikBf+Wwkr6Qwy2RGMtDkbq+tPx+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Zs5byTPpsTQLmRReL98a7KdRFFFsX9g362JxT+hmqya6+qWQ
	UQHkXBWAWF2fdUKdRehGhlhBSKd+N8BizPsnBJM3MRQPRaJyE2RyIvLoOSp+P4kiPweeKOlH3Qi
	grG7iDOAZR1BIjkVMoHh1cupgcbHIXEtH2CEd
X-Google-Smtp-Source: AGHT+IGFfsCLFlXzIE4WL4lQnY+XmKm9FIKr65q8ol/AeEEWv1q+PbbdIPzm2vHXkvsahYdpARV3nr7pGfpfrshTuL0=
X-Received: by 2002:a25:a282:0:b0:e20:1e5f:bc9a with SMTP id
 3f1490d57ef6-e202769c379mr3068158276.11.1726761940768; Thu, 19 Sep 2024
 09:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
In-Reply-To: <66ec25cb.050a0220.92ef1.001e.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 12:05:29 -0400
Message-ID: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
To: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
Cc: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000017a5ae06227b1880"

--00000000000017a5ae06227b1880
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 9:23=E2=80=AFAM syzbot
<syzbot+044fdf24e96093584232@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bdf56c7580d2 Merge tag 'slab-for-6.12' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12584b0058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4540f5bcdd31e=
3de
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D044fdf24e960935=
84232
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D155cffc7980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ad24a998000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cec9f3c675f1/dis=
k-bdf56c75.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/21e06ae5b159/vmlinu=
x-bdf56c75.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1e936c954b8b/b=
zImage-bdf56c75.xz
>
> The issue was bisected to:
>
> commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Wed Jul 10 21:32:26 2024 +0000
>
>     lsm: infrastructure management of the key security blob
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1124d69f98=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1324d69f98=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1524d69f98000=
0

I just posted a patch which I believe should fix the problem, but I'd
like to get Casey's ACK on it before submitting upstream as it does
touch Smack code; lore link below:

https://lore.kernel.org/linux-security-module/20240919155740.29539-2-paul@p=
aul-moore.com

... in the meantime, I'm attaching the patch here so syzbot can verify
that it solves the problem.

#syz test

--=20
paul-moore.com

--00000000000017a5ae06227b1880
Content-Type: text/x-patch; charset="US-ASCII"; name="01-lsm-key_blob_fix.patch"
Content-Disposition: attachment; filename="01-lsm-key_blob_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m19hg97b0>
X-Attachment-Id: f_m19hg97b0

c2VsaW51eCxzbWFjazogcHJvcGVybHkgcmVmZXJlbmNlIHRoZSBMU00gYmxvYiBpbiBzZWN1cml0
eV93YXRjaF9rZXkoKQoKRnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KClVu
Zm9ydHVuYXRlbHkgd2hlbiB3ZSBtaWdyYXRlZCB0aGUgbGlmZWN5Y2xlIG1hbmFnZW1lbnQgb2Yg
dGhlIGtleSBMU00KYmxvYiB0byB0aGUgTFNNIGZyYW1ld29yayB3ZSBmb3Jnb3QgdG8gY29udmVy
dCB0aGUgc2VjdXJpdHlfd2F0Y2hfa2V5KCkKY2FsbGJhY2tzIGZvciBTRUxpbnV4IGFuZCBTbWFj
ay4gIFRoaXMgcGF0Y2ggY29ycmVjdHMgdGhpcyBieSBtYWtpbmcgdXNlCm9mIHRoZSBzZWxpbnV4
X2tleSgpIGFuZCBzbWFja19rZXkoKSBoZWxwZXIgZnVuY3Rpb25zIHJlc3BlY3RpdmVseS4KClRo
aXMgcGF0Y2ggYWxzbyByZW1vdmVzIHNvbWUgaW5wdXQgY2hlY2tpbmcgaW4gdGhlIFNtYWNrIGNh
bGxiYWNrIGFzIGl0CmlzIG5vIGxvbmdlciBuZWVkZWQuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzA0
NGZkZjI0ZTk2MDkzNTg0MjMyQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KRml4ZXM6IDVmOGQy
OGY2ZDdkNSAoImxzbTogaW5mcmFzdHJ1Y3R1cmUgbWFuYWdlbWVudCBvZiB0aGUga2V5IHNlY3Vy
aXR5IGJsb2IiKQpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29t
PgotLS0KIHNlY3VyaXR5L3NlbGludXgvaG9va3MuYyAgIHwgICAgMiArLQogc2VjdXJpdHkvc21h
Y2svc21hY2tfbHNtLmMgfCAgIDEzICsrKy0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxp
bnV4L2hvb2tzLmMgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKaW5kZXggODFmYmZhNWI4MGQ0
Li42N2JhYTQ4N2NmN2EgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYworKysg
Yi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMKQEAgLTY3MjAsNyArNjcyMCw3IEBAIHN0YXRpYyBp
bnQgc2VsaW51eF9rZXlfZ2V0c2VjdXJpdHkoc3RydWN0IGtleSAqa2V5LCBjaGFyICoqX2J1ZmZl
cikKICNpZmRlZiBDT05GSUdfS0VZX05PVElGSUNBVElPTlMKIHN0YXRpYyBpbnQgc2VsaW51eF93
YXRjaF9rZXkoc3RydWN0IGtleSAqa2V5KQogewotCXN0cnVjdCBrZXlfc2VjdXJpdHlfc3RydWN0
ICprc2VjID0ga2V5LT5zZWN1cml0eTsKKwlzdHJ1Y3Qga2V5X3NlY3VyaXR5X3N0cnVjdCAqa3Nl
YyA9IHNlbGludXhfa2V5KGtleSk7CiAJdTMyIHNpZCA9IGN1cnJlbnRfc2lkKCk7CiAKIAlyZXR1
cm4gYXZjX2hhc19wZXJtKHNpZCwga3NlYy0+c2lkLCBTRUNDTEFTU19LRVksIEtFWV9fVklFVywg
TlVMTCk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYyBiL3NlY3VyaXR5
L3NtYWNrL3NtYWNrX2xzbS5jCmluZGV4IGRhMGMyYmZmYmQwOC4uNTYzZmI0MDRmNjU5IDEwMDY0
NAotLS0gYS9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYworKysgYi9zZWN1cml0eS9zbWFjay9z
bWFja19sc20uYwpAQCAtNDYyOSwxNiArNDYyOSw5IEBAIHN0YXRpYyBpbnQgc21hY2tfd2F0Y2hf
a2V5KHN0cnVjdCBrZXkgKmtleSkKIHsKIAlzdHJ1Y3Qgc21rX2F1ZGl0X2luZm8gYWQ7CiAJc3Ry
dWN0IHNtYWNrX2tub3duICp0a3AgPSBzbWtfb2ZfY3VycmVudCgpOworCXN0cnVjdCBzbWFja19r
bm93biAqKmJsb2IgPSBzbWFja19rZXkoa2V5KTsKIAlpbnQgcmM7CiAKLQlpZiAoa2V5ID09IE5V
TEwpCi0JCXJldHVybiAtRUlOVkFMOwotCS8qCi0JICogSWYgdGhlIGtleSBoYXNuJ3QgYmVlbiBp
bml0aWFsaXplZCBnaXZlIGl0IGFjY2VzcyBzbyB0aGF0Ci0JICogaXQgbWF5IGRvIHNvLgotCSAq
LwotCWlmIChrZXktPnNlY3VyaXR5ID09IE5VTEwpCi0JCXJldHVybiAwOwogCS8qCiAJICogVGhp
cyBzaG91bGQgbm90IG9jY3VyCiAJICovCkBAIC00NjUzLDggKzQ2NDYsOCBAQCBzdGF0aWMgaW50
IHNtYWNrX3dhdGNoX2tleShzdHJ1Y3Qga2V5ICprZXkpCiAJYWQuYS51LmtleV9zdHJ1Y3Qua2V5
ID0ga2V5LT5zZXJpYWw7CiAJYWQuYS51LmtleV9zdHJ1Y3Qua2V5X2Rlc2MgPSBrZXktPmRlc2Ny
aXB0aW9uOwogI2VuZGlmCi0JcmMgPSBzbWtfYWNjZXNzKHRrcCwga2V5LT5zZWN1cml0eSwgTUFZ
X1JFQUQsICZhZCk7Ci0JcmMgPSBzbWtfYnVfbm90ZSgia2V5IHdhdGNoIiwgdGtwLCBrZXktPnNl
Y3VyaXR5LCBNQVlfUkVBRCwgcmMpOworCXJjID0gc21rX2FjY2Vzcyh0a3AsICpibG9iLCBNQVlf
UkVBRCwgJmFkKTsKKwlyYyA9IHNta19idV9ub3RlKCJrZXkgd2F0Y2giLCB0a3AsICpibG9iLCBN
QVlfUkVBRCwgcmMpOwogCXJldHVybiByYzsKIH0KICNlbmRpZiAvKiBDT05GSUdfS0VZX05PVElG
SUNBVElPTlMgKi8K
--00000000000017a5ae06227b1880--

