Return-Path: <linux-kernel+bounces-199817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D48FA661
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA532864DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9383CD8;
	Mon,  3 Jun 2024 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcF0Gyxk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87F839FF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457084; cv=none; b=tjDirN6Lml9xDsRmKTM9ZelWcZ3An7Um2P61LbVhs+aCJ5BW3FI3cvgrQKkVFESfAb4cjjeWJ7gUNxCUA9E2F2hqdhLu6WYSuon6zbDEZs7hQSaDtcpxdwLfiAI2tXwhYgilhu1hTWL2aW4+udn6bCnFv0HNEidbw39v4U5uS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457084; c=relaxed/simple;
	bh=QBLCRTunBvprBc7oZCp9ruJkD/TqH8uaiVHpEr+KQJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHCXOP0HsevkDI1+2D+G99J8R/IggokpN8be0zC06k+AHp/O/9yXAODdouCKlnMxx9dLPVWB1rmZN7+1p192W301gkwXMMvglqNwxW9LG/N8kO1b6vUxVns0pyOT7kWUP4JZ56arMHKlDahSzIMMTiaPefOHDJ8lTvpUj3nKvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcF0Gyxk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eabd22d441so2483901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717457081; x=1718061881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uI9O5jaQ0kfa653hSR6g4hwsO4WQYRAKjh78vr8MtSY=;
        b=jcF0GyxkEmSunjMBDv5qstsbjo2pR3cwbXv+/GYoKkKaAHkA2agM7o2VyWQbo5b+xD
         fEkJ64z8mxBb9aGhOeu4NNnQyhrvoekuq1Br+G9xIioeUhYjkhAUpbYFDn1V10bqNn+z
         qUc4JXtPKJ03PJ/lCs6F2O1K1qunpu1dVzHPQl4kchnm4T0A5o4btI50irTuWly4NFi3
         Pqi8Z349kcjeeUrm9Z0FNSAgt94ed0Aa1xSgzmMFmnZ0EmLKja8r/h9Wsum6z9UdGQU6
         4GpUsXLkCw56EjyZZDTK0pTWmY5rjiOeTG1FSl957JhZlPSmPo2dcc5Bmup8sgaRPyDq
         kNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717457081; x=1718061881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI9O5jaQ0kfa653hSR6g4hwsO4WQYRAKjh78vr8MtSY=;
        b=i5lTTVNOF4CwVNheSyLrWKuhLMTBW8jaoUJZKV88pTtuB1u4hbIrxtUpAB1W/5/3Z7
         h0Za/QtbrgJC0UWI3FOcRe4Awtu90qPdjVVHB+krqR9hUlydpfvIlXQvfAtfHxT6IlAt
         qmcPHmusAsJCU2ZBO8bVNa+RuoqijD1E5g+0rhaKRaKCKvKJUWRvD3d8HiiDi1SDXyjE
         emnRzn8aqjnpzcesVws6EIKN5Og5z33Ubv67AcSnrU0IyDGjPzmwth07uX6sIwQQ0Xut
         LdFMTcdpQGcH8ZWQfI8zs79SzC51564DSTrPx6o8yH9XCD+jcdgLQc26nKEPgvmei8F+
         9khA==
X-Forwarded-Encrypted: i=1; AJvYcCUwFrAj2fYZ4MK/y1IeMqU3sF14nM9n+T92qepQm2MhqDUxlZGFzc6qNSAxdL1YNLOqkIMCCv1HD+pc0BS+0xoOcSVB+KgGMLuMw65h
X-Gm-Message-State: AOJu0Yx7Wzui4DZmtNLaeV29eGAOxOVFasuV5VNZKA4TJ2ccH3fkewSZ
	xsu90uiQOymg314+/Ag9vy6QF4esXd9zoRJo0/yLwfJRh/BhsqoXzUfC5DMCTc0SvvNy1Kv7gnA
	vhmaY3WSf/r4z4qjjhZ5znEF/EQknheZPE9sGFjnRfex7E1tt+50s
X-Google-Smtp-Source: AGHT+IEUNuM7g9YhDLjaOVQ6ME5e+H6g213LZO/+a9W4oW0WyCXsRz0fuPpEZFPzvaRVcCL1qlZJdtZGuETggOjtRqc=
X-Received: by 2002:a2e:9d88:0:b0:2e1:9c57:195a with SMTP id
 38308e7fff4ca-2ea951de27fmr86665761fa.32.1717457080443; Mon, 03 Jun 2024
 16:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
In-Reply-To: <20240604001304.5420284f@yea>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 3 Jun 2024 16:24:02 -0700
Message-ID: <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="00000000000033ca02061a04a3f5"

--00000000000033ca02061a04a3f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:13=E2=80=AFPM Erhard Furtner <erhard_f@mailbox.org=
> wrote:
>
> On Sun, 2 Jun 2024 20:03:32 +0200
> Erhard Furtner <erhard_f@mailbox.org> wrote:
>
> > On Sat, 1 Jun 2024 00:01:48 -0600
> > Yu Zhao <yuzhao@google.com> wrote:
> >
> > > The OOM kills on both kernel versions seem to be reasonable to me.
> > >
> > > Your system has 2GB memory and it uses zswap with zsmalloc (which is
> > > good since it can allocate from the highmem zone) and zstd/lzo (which
> > > doesn't matter much). Somehow -- I couldn't figure out why -- it
> > > splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
> > >
> > > [    0.000000] Zone ranges:
> > > [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> > > [    0.000000]   Normal   empty
> > > [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> > >
> > > The kernel can't allocate from the highmem zone -- only userspace and
> > > zsmalloc can. OOM kills were due to the low memory conditions in the
> > > DMA zone where the kernel itself failed to allocate from.
> > >
> > > Do you know a kernel version that doesn't have OOM kills while runnin=
g
> > > the same workload? If so, could you send that .config to me? If not,
> > > could you try disabling CONFIG_HIGHMEM? (It might not help but I'm ou=
t
> > > of ideas at the moment.)
>
> Ok, the bisect I did actually revealed something meaningful:
>
>  # git bisect good
> b8cf32dc6e8c75b712cbf638e0fd210101c22f17 is the first bad commit
> commit b8cf32dc6e8c75b712cbf638e0fd210101c22f17
> Author: Yosry Ahmed <yosryahmed@google.com>
> Date:   Tue Jun 20 19:46:44 2023 +0000
>
>     mm: zswap: multiple zpools support

Thanks for bisecting. Taking a look at the thread, it seems like you
have a very limited area of memory to allocate kernel memory from. One
possible reason why that commit can cause an issue is because we will
have multiple instances of the zsmalloc slab caches 'zspage' and
'zs_handle', which may contribute to fragmentation in slab memory.

Do you have /proc/slabinfo from a good and a bad run by any chance?

Also, could you check if the attached patch helps? It makes sure that
even when we use multiple zsmalloc zpools, we will use a single slab
cache of each type.

--00000000000033ca02061a04a3f5
Content-Type: application/octet-stream; 
	name="0001-mm-zsmalloc-share-slab-caches-for-all-zsmalloc-zpool.patch"
Content-Disposition: attachment; 
	filename="0001-mm-zsmalloc-share-slab-caches-for-all-zsmalloc-zpool.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lwzlkqoq0>
X-Attachment-Id: f_lwzlkqoq0

RnJvbSAxYWMwZmEzNDc4M2Y2NmVhNzMzNGZkMmU5MTI5YmMzNjJiZWU1MWRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPgpE
YXRlOiBTYXQsIDEzIE1heSAyMDIzIDAxOjEwOjM0ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbW06
IHpzbWFsbG9jOiBzaGFyZSBzbGFiIGNhY2hlcyBmb3IgYWxsIHpzbWFsbG9jIHpwb29scwoKWnN3
YXAgY3JlYXRlcyAzMiB6cG9vbHMgdG8gaW1wcm92ZSBjb25jdXJyZW5jeS4gRWFjaCB6c21hbGxv
YyB6cG9vbApjcmVhdGVzIGl0cyBvd24gJ3pzX2hhbmRsZScgYW5kICd6c3BhZ2UnIHNsYWIgY2Fj
aGVzLiBXZSBlbmQgdXAgd2l0aCAzMgpzbGFiIGNhY2hlcyBvZiBlYWNoIHR5cGUuCgpTaW5jZSBl
YWNoIHNsYWIgY2FjaGUgaG9sZHMgc29tZSBmcmVlIG9iamVjdHMsIHdlIGVuZCB1cCB3aXRoIGEg
bG90IG9mCmZyZWUgb2JqZWN0cyBkaXN0cmlidXRlZCBhbW9uZyB0aGUgc2VwYXJhdGUgenBvb2wg
Y2FjaGVzLiBTbGFiIGNhY2hlcwphcmUgZGVzaWduZWQgdG8gaGFuZGxlIGNvbmN1cnJlbnQgYWxs
b2NhdGlvbnMgYnkgdXNpbmcgcGVyY3B1CnN0cnVjdHVyZXMsIHNvIGhhdmluZyBhIHNpbmdsZSBp
bnN0YW5jZSBvZiBlYWNoIGNhY2hlIHNob3VsZCBiZSBlbm91Z2gsCmFuZCBhdm9pZHMgd2FzdGlu
ZyBtb3JlIG1lbW9yeSB0aGFuIG5lZWRlZCBkdWUgdG8gZnJhZ21lbnRhdGlvbi4KCkFkZGl0aW9u
YWxseSwgaGF2aW5nIG1vcmUgc2xhYiBjYWNoZXMgdGhhbiBuZWVkZWQgdW5uZWNlc3NhcmlseSBz
bG93cwpkb3duIGNvZGUgcGF0aHMgdGhhdCBpdGVyYXRlIHNsYWJfY2FjaGVzLgoKU2lnbmVkLW9m
Zi1ieTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4KLS0tCiBtbS96c21hbGxv
Yy5jIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbW0venNtYWxsb2MuYyBiL21tL3pzbWFsbG9jLmMKaW5kZXggYjQyZDM1NDVj
YTg1Ni4uYzNjOTA2MThlYzhiNCAxMDA2NDQKLS0tIGEvbW0venNtYWxsb2MuYworKysgYi9tbS96
c21hbGxvYy5jCkBAIC0yODksMjkgKzI4OSw4IEBAIHN0YXRpYyB2b2lkIGluaXRfZGVmZXJyZWRf
ZnJlZShzdHJ1Y3QgenNfcG9vbCAqcG9vbCkge30KIHN0YXRpYyB2b2lkIFNldFpzUGFnZU1vdmFi
bGUoc3RydWN0IHpzX3Bvb2wgKnBvb2wsIHN0cnVjdCB6c3BhZ2UgKnpzcGFnZSkge30KICNlbmRp
ZgogCi1zdGF0aWMgaW50IGNyZWF0ZV9jYWNoZShzdHJ1Y3QgenNfcG9vbCAqcG9vbCkKLXsKLQlw
b29sLT5oYW5kbGVfY2FjaGVwID0ga21lbV9jYWNoZV9jcmVhdGUoInpzX2hhbmRsZSIsIFpTX0hB
TkRMRV9TSVpFLAotCQkJCQkwLCAwLCBOVUxMKTsKLQlpZiAoIXBvb2wtPmhhbmRsZV9jYWNoZXAp
Ci0JCXJldHVybiAxOwotCi0JcG9vbC0+enNwYWdlX2NhY2hlcCA9IGttZW1fY2FjaGVfY3JlYXRl
KCJ6c3BhZ2UiLCBzaXplb2Yoc3RydWN0IHpzcGFnZSksCi0JCQkJCTAsIDAsIE5VTEwpOwotCWlm
ICghcG9vbC0+enNwYWdlX2NhY2hlcCkgewotCQlrbWVtX2NhY2hlX2Rlc3Ryb3kocG9vbC0+aGFu
ZGxlX2NhY2hlcCk7Ci0JCXBvb2wtPmhhbmRsZV9jYWNoZXAgPSBOVUxMOwotCQlyZXR1cm4gMTsK
LQl9Ci0KLQlyZXR1cm4gMDsKLX0KLQotc3RhdGljIHZvaWQgZGVzdHJveV9jYWNoZShzdHJ1Y3Qg
enNfcG9vbCAqcG9vbCkKLXsKLQlrbWVtX2NhY2hlX2Rlc3Ryb3kocG9vbC0+aGFuZGxlX2NhY2hl
cCk7Ci0Ja21lbV9jYWNoZV9kZXN0cm95KHBvb2wtPnpzcGFnZV9jYWNoZXApOwotfQorc3RhdGlj
IHN0cnVjdCBrbWVtX2NhY2hlICp6c19oYW5kbGVfY2FjaGU7CitzdGF0aWMgc3RydWN0IGttZW1f
Y2FjaGUgKnpzcGFnZV9jYWNoZTsKIAogc3RhdGljIHVuc2lnbmVkIGxvbmcgY2FjaGVfYWxsb2Nf
aGFuZGxlKHN0cnVjdCB6c19wb29sICpwb29sLCBnZnBfdCBnZnApCiB7CkBAIC0yMTA3LDEzICsy
MDg2LDEzIEBAIHN0cnVjdCB6c19wb29sICp6c19jcmVhdGVfcG9vbChjb25zdCBjaGFyICpuYW1l
KQogCXNwaW5fbG9ja19pbml0KCZwb29sLT5sb2NrKTsKIAlhdG9taWNfc2V0KCZwb29sLT5jb21w
YWN0aW9uX2luX3Byb2dyZXNzLCAwKTsKIAorCXBvb2wtPmhhbmRsZV9jYWNoZXAgPSB6c19oYW5k
bGVfY2FjaGU7CisJcG9vbC0+enNwYWdlX2NhY2hlcCA9IHpzcGFnZV9jYWNoZTsKKwogCXBvb2wt
Pm5hbWUgPSBrc3RyZHVwKG5hbWUsIEdGUF9LRVJORUwpOwogCWlmICghcG9vbC0+bmFtZSkKIAkJ
Z290byBlcnI7CiAKLQlpZiAoY3JlYXRlX2NhY2hlKHBvb2wpKQotCQlnb3RvIGVycjsKLQogCS8q
CiAJICogSXRlcmF0ZSByZXZlcnNlbHksIGJlY2F1c2UsIHNpemUgb2Ygc2l6ZV9jbGFzcyB0aGF0
IHdlIHdhbnQgdG8gdXNlCiAJICogZm9yIG1lcmdpbmcgc2hvdWxkIGJlIGxhcmdlciBvciBlcXVh
bCB0byBjdXJyZW50IHNpemUuCkBAIC0yMjM0LDE2ICsyMjEzLDQxIEBAIHZvaWQgenNfZGVzdHJv
eV9wb29sKHN0cnVjdCB6c19wb29sICpwb29sKQogCQlrZnJlZShjbGFzcyk7CiAJfQogCi0JZGVz
dHJveV9jYWNoZShwb29sKTsKIAlrZnJlZShwb29sLT5uYW1lKTsKIAlrZnJlZShwb29sKTsKIH0K
IEVYUE9SVF9TWU1CT0xfR1BMKHpzX2Rlc3Ryb3lfcG9vbCk7CiAKK3N0YXRpYyB2b2lkIHpzX2Rl
c3Ryb3lfY2FjaGVzKHZvaWQpCit7CisJa21lbV9jYWNoZV9kZXN0cm95KHpzX2hhbmRsZV9jYWNo
ZSk7CisJa21lbV9jYWNoZV9kZXN0cm95KHpzcGFnZV9jYWNoZSk7CisJenNfaGFuZGxlX2NhY2hl
ID0gTlVMTDsKKwl6c3BhZ2VfY2FjaGUgPSBOVUxMOworfQorCitzdGF0aWMgaW50IHpzX2NyZWF0
ZV9jYWNoZXModm9pZCkKK3sKKwl6c19oYW5kbGVfY2FjaGUgPSBrbWVtX2NhY2hlX2NyZWF0ZSgi
enNfaGFuZGxlIiwgWlNfSEFORExFX1NJWkUsCisJCQkJCSAgICAwLCAwLCBOVUxMKTsKKwl6c3Bh
Z2VfY2FjaGUgPSBrbWVtX2NhY2hlX2NyZWF0ZSgienNwYWdlIiwgc2l6ZW9mKHN0cnVjdCB6c3Bh
Z2UpLAorCQkJCQkgMCwgMCwgTlVMTCk7CisKKwlpZiAoIXpzX2hhbmRsZV9jYWNoZSB8fCAhenNw
YWdlX2NhY2hlKSB7CisJCXpzX2Rlc3Ryb3lfY2FjaGVzKCk7CisJCXJldHVybiAtMTsKKwl9CisJ
cmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgX19pbml0IHpzX2luaXQodm9pZCkKIHsKIAlpbnQg
cmV0OwogCisJcmV0ID0genNfY3JlYXRlX2NhY2hlcygpOworCWlmIChyZXQpCisJCWdvdG8gb3V0
OworCiAJcmV0ID0gY3B1aHBfc2V0dXBfc3RhdGUoQ1BVSFBfTU1fWlNfUFJFUEFSRSwgIm1tL3pz
bWFsbG9jOnByZXBhcmUiLAogCQkJCXpzX2NwdV9wcmVwYXJlLCB6c19jcHVfZGVhZCk7CiAJaWYg
KHJldCkKQEAgLTIyNTgsNiArMjI2Miw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHpzX2luaXQodm9p
ZCkKIAlyZXR1cm4gMDsKIAogb3V0OgorCXpzX2Rlc3Ryb3lfY2FjaGVzKCk7CiAJcmV0dXJuIHJl
dDsKIH0KIApAQCAtMjI2OSw2ICsyMjc0LDcgQEAgc3RhdGljIHZvaWQgX19leGl0IHpzX2V4aXQo
dm9pZCkKIAljcHVocF9yZW1vdmVfc3RhdGUoQ1BVSFBfTU1fWlNfUFJFUEFSRSk7CiAKIAl6c19z
dGF0X2V4aXQoKTsKKwl6c19kZXN0cm95X2NhY2hlcygpOwogfQogCiBtb2R1bGVfaW5pdCh6c19p
bml0KTsKLS0gCjIuNDUuMS4yODguZzBlMGNkMjk5ZjEtZ29vZwoK
--00000000000033ca02061a04a3f5--

