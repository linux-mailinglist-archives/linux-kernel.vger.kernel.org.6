Return-Path: <linux-kernel+bounces-574606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD2A6E795
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1781317404D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8381732;
	Tue, 25 Mar 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHRDuH2o"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0657C9F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742862110; cv=none; b=pL8E0wsyz09f2IxWCyhkC+ubnmOF/t0CS2cxnzvzSAgkOTN3N5Dy9ed5jiGMw2ZZtn5dpUIg7KGnmi+46jtQcUYeUK05GL9fvULXSkXlHNfTC/v9FOA5hEVRmnCo+km4g7wcTpW66TUx+/OaubwaDqkhZUqji/SGyjTMhv9/G9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742862110; c=relaxed/simple;
	bh=vrj35GYsxNq9sLVJo6Xi68dZRxTptMeao+yGxpd7dYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGWZHUCwQxwq15tFZbTQes+gPu9XiwoxEqrn/bqs11euNYO+v5bXhZwRNI+7FnALM0723jIxM9EEQfX8bP6zH1THykqNjFq1bLgyoJbR03Ql39ZleueJb6U1L0OVgKaaB82gmrmrudkvini/f9p5Vf9tpUkVH/0a1WI/msX4KmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHRDuH2o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225505d1ca5so79220485ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742862108; x=1743466908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8y09wjWZKZXgN+OK6vm5oWH5+mueKid+6zGQwN3TE=;
        b=EHRDuH2oeDAdWBCfFcLk4ugHp0+QF2zJ163DPdc74wvbz12fWe55OmupORyBfmAkJk
         7zi7ggzYJJQahDptjPVfaUBsEHqLNeZKhhVAaIXJxc+wlrxPunRLx/ayPQORmByHTuXk
         3Hd+Abvpy762noQJUwZzwZp7vrLq7OGVjxSZaApZHJHPw6iSqbnRzrBx60kKE9y/JCZb
         wYX8ewgTP7odMGMJEEwxzx51pZIQvZb7Sy3QVPSVUw8BVNy8zG6JRdDG834+ACclm02x
         0d+1PCNQMgB8kuaZDaHmBLyHR3ZCcWZluYe6OdEgoI57NGhhBKUmbGoI8wpF70rRcT8j
         te/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742862108; x=1743466908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8y09wjWZKZXgN+OK6vm5oWH5+mueKid+6zGQwN3TE=;
        b=dTDCoQ5mX+7veWn6CBXp+leqDEb8/57AvocqxnlsjqCHnycqct17HpBxKBZeH2O+wO
         FG6eI03oIs3aMUJVb7HDkcRkWL2VFKcIU51NTDYlN/kEnejitLGX5F3uYHgGopRjY0To
         dGboY14A23MGYQ6byLauwVhDFkNCaesH5dcBOA3nfMMMAEYmv61J5m2aRMmO/VzmEP0g
         Xc8ubWiISu/FKN+DXUlYSDNV2OnG4chuBPCaZ/bKHQrZD/zGAYdVh1obzEQNxlUd55s2
         QVJTUs4MDTQJWDS9xLj0TREpLb/ackNdmfn0RRyxf4uOLZyNUgAnOR+hlSFjlhUrYilk
         TB8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOoZG7dUMfp2iOUI2q+x+JCT9nNiZhkW+XudmahJ+77Bl4cYti2NhwZZDh8ho1vPGpE1fTsx1inid72Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Lni1mV8JI4KwtTcvPytBDNa4RMqtgt4zvcqWEoqI3eipUPMW
	BgZz1N8hVjXJlP95gUbOgvmLOtykXAdl5quLUc0yzq8chuMZ/xEb3/fRgbXnZLHHln6Aq+emU3n
	N6eNxxhhaahNPpYtdCg==
X-Google-Smtp-Source: AGHT+IHG0g+Hm1IqtMzqXUj5Qn0QldzYjiLvO8Nyoi1zqCX0pxtjOavFlFPqDc4bNSQjw3dO9geHCTStZpDWLXuA
X-Received: from pfbgi10.prod.google.com ([2002:a05:6a00:63ca:b0:736:59f0:d272])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c7:0:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-7390593d43fmr22362509b3a.2.1742862108166;
 Mon, 24 Mar 2025 17:21:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:21:45 -0700
In-Reply-To: <Z+GIRecXeYXiPrYv@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z+GIRecXeYXiPrYv@nvidia.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325002145.982402-1-changyuanl@google.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: jgg@nvidia.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, 
	robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Mon, Mar 24, 2025 at 13:28:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> [...]
> > > I feel like this patch is premature, it should come later in the
> > > project along with a stronger justification for this approach.
> > >
> > > IHMO keep things simple for this series, just the very basics.
> >
> > The main purpose of using hashtables is to enable KHO users to save
> > data to KHO at any time, not just at the time of activate/finalize KHO
> > through sysfs/debugfs. For example, FDBox can save the data into KHO
> > tree once a new fd is saved to KHO. Also, using hashtables allows KHO
> > users to add data to KHO concurrently, while with notifiers, KHO users'
> > callbacks are executed serially.
>
> This is why I like the recursive FDT scheme. Each serialization
> operation can open its own FDT write to it and the close it
> sequenatially within its operation without any worries about
> concurrency.
>
> The top level just aggregates the FDT blobs (which are in preserved
> memory)
>
> To me all this complexity here with the hash table and the copying
> makes no sense compared to that. It is all around slower.
>
> > Regarding the suggestion of recursive FDT, I feel like it is already
> > doable with this patchset, or even with Mike's V4 patch.
>
> Of course it is doable, here we are really talk about what is the
> right, recommended way to use this system. recurisive FDT is a better
> methodology than hash tables
>
> > just allocates a buffer, serialize all its states to the buffer using
> > libfdt (or even using other binary formats), save the address of the
> > buffer to KHO's tree, and finally register the buffer's underlying
> > pages/folios with kho_preserve_folio().
>
> Yes, exactly! I think this is how we should operate this system as a
> paradig, not a giant FDT, hash table and so on...
>
> [...]
> > To completely remove fdt_max, I am considering the idea in [1]. At the
> > time of kexec_file_load(), we pass the address of an anchor page to
> > the new kernel, and the anchor page will later be fulfilled with the
> > physical addresses of the pages containing the FDT blob. Multiple
> > anchor pages can be linked together. The FDT blob pages can be physically
> > noncontiguous.
>
> Yes, this is basically what I suggested too. I think this is much
> prefered and doesn't require the wakky uapi.
>
> Except I suggested you just really need a single u64 to point to a
> preserved page holding the top level FDT.
>
> With recursive FDT I think we can say that no FDT fragement should
> exceed PAGE_SIZE, and things become much simpler, IMHO.

Thanks for the suggestions! I am a little bit concerned about assuming
every FDT fragment is smaller than PAGE_SIZE. In case a child FDT is
larger than PAGE_SIZE, I would like to turn the single u64 in the parent
FDT into a u64 list to record all the underlying pages of the child FDT.

To be concrete and make sure I understand your suggestions correctly,
I drafted the following design,

Suppose we have 2 KHO users, memblock and gpu@0x2000000000, the KHO
FDT (top level FDT) would look like the following,

    /dts-v1/;
    / {
            compatible = "kho-v1";
            memblock {
                    kho,recursive-fdt = <0x00 0x40001000>;
            };
            gpu@0x100000000 {
                    kho,recursive-fdt = <0x00 0x40002000>;
            };
    };

kho,recursive-fdt in "memblock" points to a page containing another
FDT,

    / {
            compatible = "memblock-v1";
            n1 {
                    compatible = "reserve-mem-v1";
                    size = <0x04 0x00>;
                    start = <0xc06b 0x4000000>;
            };
            n2 {
                    compatible = "reserve-mem-v1";
                    size = <0x04 0x00>;
                    start = <0xc067 0x4000000>;
            };
    };

Similarly, "kho,recursive-fdt" in "gpu@0x2000000000" points to a page
containing another FDT,

    / {
            compatible = "gpu-v1"
            key1 = "v1";
            key2 = "v2";

            node1 {
                    kho,recursive-fdt = <0x00 0x40003000 0x00 0x40005000>;
            }
            node2 {
                    key3 = "v3";
                    key4 = "v4";
            }
    }

and kho,recursive-fdt in "node1" contains 2 non-contagious pages backing
the following large FDT fragment,

    / {
            compatible = "gpu-subnode1-v1";

            key5 = "v5";
            key6 = "v6";
            key7 = "v7";
            key8 = "v8";
            ... // many many keys and small values
    }

In this way we assume that most FDT fragment is smaller than 1 page so
"kho,recursive-fdt" is usually just 1 u64, but we can also handle
larger fragments if that really happens.

I also allow KHO users to add sub nodes in-place, instead of forcing
to create a new FDT fragment for every sub node, if the KHO user is
confident that those subnodes are small enough to fit in the parent
node's page. In this way we do not need to waste a full page for a small
sub node. An example is the "memblock" node above.

Finally, the KHO top level FDT may also be larger than 1 page, this can
be handled using the anchor-page method discussed in the previous mails.

What do you think?

Best,
Changyuan

