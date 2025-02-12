Return-Path: <linux-kernel+bounces-511484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299DA32B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95859167DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3A2236F2;
	Wed, 12 Feb 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5VNN6A9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FB1DC19E;
	Wed, 12 Feb 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377827; cv=none; b=uJAU0AznoyeYpHlYPm+le/9gWyrvzUfXAT/DBqzKSiolmZO7KJTAfYgEe+hqwsvWf9kAcwXNJg5WnLgDk50Tc7ThTmr8ZZIU7P8hdoSlVAFGBt6q0xChUkKSYWct4V6HYQnqAZUUguZTMU7zxymYZrYVmM79Wt5flKh9wRplZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377827; c=relaxed/simple;
	bh=NccZL8Q08RvCQ8Ff9ijQSz4W4tvbRtmCRMiRukZabfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEpE1MupLeQ2LQNdA6Diwum69+Jjia5Ff9QemGM7PmHRfkW/QKcECBVsfbo8KAP+9Avu9OthmSsZQZon6zedq2d5hlUD6peOep7Ui8agZlAnCgAtZsVePhrSFym5pyEN/ikCTvnfRTpZNtuq/q/VKRLX3oCEyEbgXo73zvPip4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5VNN6A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210DBC4CEDF;
	Wed, 12 Feb 2025 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739377827;
	bh=NccZL8Q08RvCQ8Ff9ijQSz4W4tvbRtmCRMiRukZabfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5VNN6A9D5Vn372vL8tF+GHsPd5j6QeuazrmHk7O6xbYdcKiaZBR2010QOSsEz2jo
	 gb90QyOFCRVHmkSlymAIIc7LvCgmVFoXvdI7Qh/uZocFl9KWJ+w5xeAjgYLZFlLzNu
	 6Qhf7qkg1rGF7zPWIbPVxxjJML1R7LasZjcBEJRXwm/YxlycAmzsuvjamyp7ItPLX+
	 K+oiKM4qaTlddClPKQxXVJCpq5T6cktJM3KNFWDYjCor/yybRPk7bBsIlLWr0z6J1J
	 wWtngwkN8lDNLuPbrCvjK2LX47OkQUkMXZqw0F68QHJCwTC6vMhcJIDI1byNUF9mNW
	 PHv8pukLdMynw==
Date: Wed, 12 Feb 2025 18:30:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Message-ID: <Z6zMkLhu0ALC8MfG@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-14-rppt@kernel.org>
 <CAL_JsqLBf1Vv6K5mK6x9JRqegvScSNFpAEE2iJOkJ4JuBTLsCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLBf1Vv6K5mK6x9JRqegvScSNFpAEE2iJOkJ4JuBTLsCw@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:03:58AM -0600, Rob Herring wrote:
> On Thu, Feb 6, 2025 at 7:30 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > Linux has recently gained support for "reserve_mem": A mechanism to
> > allocate a region of memory early enough in boot that we can cross our
> > fingers and hope it stays at the same location during most boots, so we
> > can store for example ftrace buffers into it.
> >
> > Thanks to KASLR, we can never be really sure that "reserve_mem"
> > allocations are static across kexec. Let's teach it KHO awareness so
> > that it serializes its reservations on kexec exit and deserializes them
> > again on boot, preserving the exact same mapping across kexec.
> >
> > This is an example user for KHO in the KHO patch set to ensure we have
> > at least one (not very controversial) user in the tree before extending
> > KHO's use to more subsystems.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 84df96efca62..fdb08b60efc1 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -16,6 +16,9 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> > +#include <linux/kexec_handover.h>
> > +#include <linux/kexec.h>
> > +#include <linux/libfdt.h>
> >
> >  #include <asm/sections.h>
> >  #include <linux/io.h>
> > @@ -2423,6 +2426,70 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
> >  }
> >  EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
> >
> > +static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
> > +                                         phys_addr_t align)
> > +{
> > +       const void *fdt = kho_get_fdt();
> > +       const char *path = "/reserve_mem";
> > +       int node, child, err;
> > +
> > +       if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
> > +               return false;
> > +
> > +       if (!fdt)
> > +               return false;
> > +
> > +       node = fdt_path_offset(fdt, "/reserve_mem");
> > +       if (node < 0)
> > +               return false;
> > +
> > +       err = fdt_node_check_compatible(fdt, node, "reserve_mem-v1");
> > +       if (err) {
> > +               pr_warn("Node '%s' has unknown compatible", path);
> > +               return false;
> > +       }
> > +
> > +       fdt_for_each_subnode(child, fdt, node) {
> > +               const struct kho_mem *mem;
> > +               const char *child_name;
> > +               int len;
> > +
> > +               /* Search for old kernel's reserved_mem with the same name */
> > +               child_name = fdt_get_name(fdt, child, NULL);
> > +               if (strcmp(name, child_name))
> > +                       continue;
> > +
> > +               err = fdt_node_check_compatible(fdt, child, "reserve_mem_map-v1");
> 
> It really seems you all are trying to have things both ways. It's not
> Devicetree, just the FDT file format, but then here you use
> "compatible" which *is* Devicetree. At best, it's all just confusing
> for folks. At worst, you're just picking and choosing what you want to
> use.
> 
> I'm not saying don't use "compatible" just for the sake of looking
> less like DT, but perhaps your versioning should be done differently.
> You are reading the 'mem' property straight into a struct. Maybe the
> struct should have a version. Or the size of the struct is the version
> much like the userspace ABI is handled for structs.

The idea is to have high level compatibility notion for node level and up
rather than verify that for each and every struct like uABI does.
For that "compatible" seems just a perfect fit.
 
> > +               if (err) {
> > +                       pr_warn("Node '%s/%s' has unknown compatible", path, name);
> > +                       continue;
> > +               }
> > +
> > +               mem = fdt_getprop(fdt, child, "mem", &len);
> > +               if (!mem || len != sizeof(*mem))
> > +                       continue;
> > +
> > +               if (mem->addr & (align - 1)) {
> 
> It's stated somewhere in this that the FDT data is LE, but here you
> are assuming the FDT is the same endianness as the CPU not that it's
> LE. Arm64 can do BE. PowerPC does both. I'm not sure if kexec from one
> endianness to another is possible. I would guess in theory it is and
> in practice it's broken already (because kexec is always an
> afterthought). Either you need to guarantee that native endianness
> will never be an issue for any arch or you need to make the endianness
> fixed.

I believe Alex mentioned little endian in the sense of native endianness
for practical purposes :)

Since arm64 does seem to support kexec from one endianness to another in
certain circumstances, but I believe that we can limit KHO only to work
when both kernels have the same endianness.
 
> Rob

-- 
Sincerely yours,
Mike.

