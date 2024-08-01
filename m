Return-Path: <linux-kernel+bounces-271053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A59448E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0168D1C21419
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B0170A2C;
	Thu,  1 Aug 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6DTGhyV"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E34503A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506377; cv=none; b=Iv6c/MazFAIjFUSre1DQaCBTofRztrrCJRnXteErrcX/2hJQidLiccfkgKJz6wvGbL1g8i6ugrSbJL7WN3QBzysE6usaUpauR5BazmfmHmjinNsGvDc3uHiOnQOUWexm82BIqo00QaCsF2FfNnsgJ5I59aWEkcMII8sCKAbqGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506377; c=relaxed/simple;
	bh=u7ZnLLaVu77BXnECO231Y0JA4oQusQygTsP5QB9c/hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKFkECEA6xi2qR/M5WdIKD59ODR8lGXkLerF5O4FFMYgnkNyFMe8hvD/jGrn564XS/Z+fyCIB8tngoYRFWrhdonoO0swnilOtAwc2GZ7Sv6MmLyqPZesHmCEOq+uLjPg4LJfee7QxZtxIe1Egqhut8eZ+5IsLw+rVWVIAyBe0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6DTGhyV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f136e23229so51449431fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722506374; x=1723111174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JhPaX4uQHlGFkWaiUtnGOcC0X6pKIzrGiqZomEed33c=;
        b=O6DTGhyVyTzG68SUPmCY1xDHv4TE8IdpqBjOd8FZuyGaMvrzqMCrcfasFTVAmgCVr6
         wWBIZvUJzdGSyw48EP7aNY+EddYvwVaN6aKojszQx02u1jUauD95hQegP6HKxM3J3lI9
         H5JAW+IukaS897Rsr9VqlUDcfzl5NxaC+SHbvTwBXwVn0YHReO0Sc3uv6N+58GiJoTgY
         Loa/N4TElH+rCYxhDxtw71D41MLWRZrG4b5LcKpXXa1Ge1azdMblElxi8uXzIT4veupX
         ETtQcI1p3HlABcQdatLTpuep12/UlyLK5CL5k8y92No4+kEmbvfBTG1ZFXTMbt4ekfSt
         jW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722506374; x=1723111174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhPaX4uQHlGFkWaiUtnGOcC0X6pKIzrGiqZomEed33c=;
        b=BQufBV3mctRSQG9ACweCMOSk48oaDoWgcFSbWYKyaJRcs+znRmA6qEt6rWuSOIIQ59
         ieEymo5X8f9TOqhJUnVj6Q+53+l2sbeCwe1GvNc5DYQq+asx3PA1Rgudf6pOGBHky3ys
         porBkpQAvP5WtPte0otKUMgC/Jj2DMzgeY52GQjujQ+HHfCZqxuvUyl5bFNQx8ite45p
         Tk2bZYwCFXBvtshALfddrQfYu4nqlG5dRmiX2NsXyEJwWXJTtCbgCSvAEdgDulH3Duda
         DFwOIdK3hWJ3o30E2E/ewmI+TleWjcJlxgoz2VRSqjg74miQzv6oxOzqJ+bq1ARYBVTx
         YzTA==
X-Forwarded-Encrypted: i=1; AJvYcCUYTe3IPdqZcCXvBQyi+KodhMO6W205qCOJyf289vU1pp6aMWE8ymmA9nKNjxfZIEP/WdhgFXma1q7iUBeha+NYfmzrkrQvfDkQg7QY
X-Gm-Message-State: AOJu0Yz88GjYd1jAr0YzZSePF+4m2zo6LLehygMCdaYXZKcB9UlUkc6k
	lqlm8Q7usF7cZWczdjwi1ohxQrhLwxtpm6JSxFKRPf9P2r9J4xD6T3lnwTs8+MLRC/IkgkQxs56
	rdjNd7idX9PbSQOqHTgcnQYvYTwI=
X-Google-Smtp-Source: AGHT+IEYbhLmlgPNsBZiRfulMt53YeMgAayYYZMsMJZajNJxW2BIjyfYaJW5JeZSAZ8hGT4xsTafvZvHcgW2Xiy3lRI=
X-Received: by 2002:a2e:bc13:0:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f1532a01ebmr19019201fa.41.1722506373699; Thu, 01 Aug 2024
 02:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org> <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com>
In-Reply-To: <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 1 Aug 2024 17:59:17 +0800
Message-ID: <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000087396d061e9c4455"

--00000000000087396d061e9c4455
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:15=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 31.07.24 08:49, Chris Li wrote:
> > This is the short term solutions "swap cluster order" listed
> > in my "Swap Abstraction" discussion slice 8 in the recent
> > LSF/MM conference.
> >
>
> Running the cow.c selftest on mm/mm-unstable, I get:

Hi David, thanks very much for the test and report!

>
> # [RUN] Basic COW after fork() with mprotect() optimization ... with swap=
ped-out, PTE-mapped THP (1024 kB)
> [   51.865309] Oops: general protection fault, probably for non-canonical=
 address 0xdead000000000108: 0000 [#1] PREEMPT SMP NOPTI
> [   51.867738] CPU: 21 UID: 0 PID: 282 Comm: kworker/21:1 Not tainted 6.1=
1.0-rc1+ #11
> [   51.869566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-2.fc40 04/01/2014
> [   51.871298] Workqueue: events swap_discard_work
> [   51.872211] RIP: 0010:__free_cluster+0x27/0x90
> [   51.873101] Code: 90 90 90 0f 1f 44 00 00 8b 0d 8d 95 96 01 55 48 89 f=
d 53 48 89 f3 85 c9 75 3a 48 8b 43 50 48 8b 4b 48 48 8d 53 48 48 83 c5 60 <=
48> 89 41 08 48 89 08 48 8b 45 08 48 89 55 08 48 89 43 50 48 89 6b
> [   51.876720] RSP: 0018:ffffa3dcc0aafdc8 EFLAGS: 00010286
> [   51.877752] RAX: dead000000000122 RBX: ffff8e7ed9686e00 RCX: dead00000=
0000100
> [   51.879186] RDX: ffff8e7ed9686e48 RSI: ffff8e7ed9686e18 RDI: ffff8e7ec=
37831c0
> [   51.880577] RBP: ffff8e7ec5d10860 R08: 0000000000000001 R09: 000000000=
0000028
> [   51.881972] R10: 0000000000000200 R11: 00000000000004cb R12: ffff8e7ed=
9686e00
> [   51.883393] R13: 0000000000028200 R14: 0000000000028000 R15: 000000000=
0000000
> [   51.884827] FS:  0000000000000000(0000) GS:ffff8e822f480000(0000) knlG=
S:0000000000000000
> [   51.886412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   51.887532] CR2: 00007f37d7e17840 CR3: 0000000335a3a001 CR4: 000000000=
0770ef0
> [   51.888931] PKRU: 55555554
> [   51.889471] Call Trace:
> [   51.889964]  <TASK>
> [   51.890391]  ? __die_body.cold+0x19/0x27
> [   51.891174]  ? die_addr+0x3c/0x60
> [   51.891824]  ? exc_general_protection+0x14f/0x430
> [   51.892754]  ? asm_exc_general_protection+0x26/0x30
> [   51.893717]  ? __free_cluster+0x27/0x90
> [   51.894483]  ? __free_cluster+0x7e/0x90
> [   51.895245]  swap_do_scheduled_discard+0x142/0x1b0
> [   51.896189]  swap_discard_work+0x26/0x30
> [   51.896958]  process_one_work+0x211/0x5a0
> [   51.897750]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   51.898693]  worker_thread+0x1c9/0x3c0
> [   51.899438]  ? __pfx_worker_thread+0x10/0x10
> [   51.900287]  kthread+0xe3/0x110
> [   51.900913]  ? __pfx_kthread+0x10/0x10
> [   51.901656]  ret_from_fork+0x34/0x50
> [   51.902377]  ? __pfx_kthread+0x10/0x10
> [   51.903114]  ret_from_fork_asm+0x1a/0x30
> [   51.903896]  </TASK>
>
>
> Maybe related to this series?

Right, I can reproduce your problem and I believe this patch can fix
it, see the attachment.

Hi Andrew, can you pick this patch too?

--00000000000087396d061e9c4455
Content-Type: application/octet-stream; 
	name="0001-SQUASH-Fix-discard-of-full-cluster.patch"
Content-Disposition: attachment; 
	filename="0001-SQUASH-Fix-discard-of-full-cluster.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzb32f6k0>
X-Attachment-Id: f_lzb32f6k0

RnJvbSAzMTM2NWY4ZDhmYTVkN2EzMDkyMDE2NmI4YzNhNjAxMzBjMjQ0MTJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlydWkgU29uZyA8a2Fzb25nQHRlbmNlbnQuY29tPgpEYXRl
OiBUaHUsIDEgQXVnIDIwMjQgMTc6Mjk6NDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBTUVVBU0g6
IEZpeCBkaXNjYXJkIG9mIGZ1bGwgY2x1c3RlcgoKU2lnbmVkLW9mZi1ieTogS2FpcnVpIFNvbmcg
PGthc29uZ0B0ZW5jZW50LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3N3YXAuaCB8IDEgKwogbW0v
c3dhcGZpbGUuYyAgICAgICAgfCA4ICsrKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N3YXAu
aCBiL2luY2x1ZGUvbGludXgvc3dhcC5oCmluZGV4IDE0NWU3OTZkYWI4NC4uMzU0M2ZmYWY5ODJl
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3N3YXAuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N3
YXAuaApAQCAtMjYwLDYgKzI2MCw3IEBAIHN0cnVjdCBzd2FwX2NsdXN0ZXJfaW5mbyB7CiAjZGVm
aW5lIENMVVNURVJfRkxBR19GUkVFIDEgLyogVGhpcyBjbHVzdGVyIGlzIGZyZWUgKi8KICNkZWZp
bmUgQ0xVU1RFUl9GTEFHX05PTkZVTEwgMiAvKiBUaGlzIGNsdXN0ZXIgaXMgb24gbm9uZnVsbCBs
aXN0ICovCiAjZGVmaW5lIENMVVNURVJfRkxBR19GUkFHIDQgLyogVGhpcyBjbHVzdGVyIGlzIG9u
IG5vbmZ1bGwgbGlzdCAqLworI2RlZmluZSBDTFVTVEVSX0ZMQUdfRlVMTCA4IC8qIFRoaXMgY2x1
c3RlciBpcyBvbiBmdWxsIGxpc3QgKi8KIAogLyoKICAqIFRoZSBmaXJzdCBwYWdlIGluIHRoZSBz
d2FwIGZpbGUgaXMgdGhlIHN3YXAgaGVhZGVyLCB3aGljaCBpcyBhbHdheXMgbWFya2VkCmRpZmYg
LS1naXQgYS9tbS9zd2FwZmlsZS5jIGIvbW0vc3dhcGZpbGUuYwppbmRleCA5ODcyZTBkYmZjNzIu
LjVhYjA2YTQ1NTY1YSAxMDA2NDQKLS0tIGEvbW0vc3dhcGZpbGUuYworKysgYi9tbS9zd2FwZmls
ZS5jCkBAIC00NTAsNyArNDUwLDEwIEBAIHN0YXRpYyB2b2lkIF9fZnJlZV9jbHVzdGVyKHN0cnVj
dCBzd2FwX2luZm9fc3RydWN0ICpzaSwgc3RydWN0IHN3YXBfY2x1c3Rlcl9pbmZvCiAJbG9ja2Rl
cF9hc3NlcnRfaGVsZCgmc2ktPmxvY2spOwogCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmNpLT5sb2Nr
KTsKIAotCWxpc3RfbW92ZV90YWlsKCZjaS0+bGlzdCwgJnNpLT5mcmVlX2NsdXN0ZXJzKTsKKwlp
ZiAoY2ktPmZsYWdzKQorCQlsaXN0X21vdmVfdGFpbCgmY2ktPmxpc3QsICZzaS0+ZnJlZV9jbHVz
dGVycyk7CisJZWxzZQorCQlsaXN0X2FkZF90YWlsKCZjaS0+bGlzdCwgJnNpLT5mcmVlX2NsdXN0
ZXJzKTsKIAljaS0+ZmxhZ3MgPSBDTFVTVEVSX0ZMQUdfRlJFRTsKIAljaS0+b3JkZXIgPSAwOwog
fQpAQCAtNDc0LDcgKzQ3Nyw2IEBAIHN0YXRpYyB2b2lkIHN3YXBfZG9fc2NoZWR1bGVkX2Rpc2Nh
cmQoc3RydWN0IHN3YXBfaW5mb19zdHJ1Y3QgKnNpKQogCQkJCVNXQVBGSUxFX0NMVVNURVIpOwog
CiAJCXNwaW5fbG9jaygmc2ktPmxvY2spOwotCiAJCXNwaW5fbG9jaygmY2ktPmxvY2spOwogCQlf
X2ZyZWVfY2x1c3RlcihzaSwgY2kpOwogCQltZW1zZXQoc2ktPnN3YXBfbWFwICsgaWR4ICogU1dB
UEZJTEVfQ0xVU1RFUiwKQEAgLTY2Niw3ICs2NjgsNyBAQCBzdGF0aWMgdm9pZCBjbHVzdGVyX2Fs
bG9jX3JhbmdlKHN0cnVjdCBzd2FwX2luZm9fc3RydWN0ICpzaSwgc3RydWN0IHN3YXBfY2x1c3Rl
cgogCQlpZiAoY2ktPmZsYWdzICYgQ0xVU1RFUl9GTEFHX0ZSQUcpCiAJCQlzaS0+ZnJhZ19jbHVz
dGVyX25yW2NpLT5vcmRlcl0tLTsKIAkJbGlzdF9tb3ZlX3RhaWwoJmNpLT5saXN0LCAmc2ktPmZ1
bGxfY2x1c3RlcnMpOwotCQljaS0+ZmxhZ3MgPSAwOworCQljaS0+ZmxhZ3MgPSBDTFVTVEVSX0ZM
QUdfRlVMTDsKIAl9CiB9CiAKLS0gCjIuNDUuMgoK
--00000000000087396d061e9c4455--

