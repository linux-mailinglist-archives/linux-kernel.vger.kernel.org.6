Return-Path: <linux-kernel+bounces-572950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F775A6D0B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8054C16DBA1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5D1624DE;
	Sun, 23 Mar 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Az3L8dq+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1413B5AE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756885; cv=none; b=eFDrBZExqsdCQ88ldKmLipWQXMyw8v89VVasZnR9KDPn3nMdiP+5iYgtcblVI0rBktxkkmZL4fvKUO4UCKhSCZzgdC8J9fjuciwzkHhyubRMAPGxHdb3klT02cJIR4x5L5k1fzudk8MzF6MI704MwvILMfqAgig8hwikC+uunU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756885; c=relaxed/simple;
	bh=+Q/fyk76Z1cDSounHVDPFMlvEhnXOKGnub0ZYWoMU+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DtFhIRUj535Id9W/u0L1RoeC+Bh/gtS5cFEHX7G3yNKVjgXQ8xQjluE/o7qBp9WjdqSWdLDsTn+TquVe0ruwT4Mb27SJpwhLR9mYBEZO6Ar0Gvar/Gdw44x3MtBHpg6xJIFmvSutFHdcuUJptD27nFSINEfXZm974pDx6OOvCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Az3L8dq+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225107fbdc7so58686415ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742756883; x=1743361683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzd5n04s6jxEJ+gCSK/dDhucMnvX+2uhB2qdLifXWko=;
        b=Az3L8dq+SQbeeJ5G4q3dk6p0wFJSbIff45SeENBII3gOMHfuG+L4lXxzK+lvt++H4l
         qSYVTtmo4J5nrAtNXVKMJuDF+e3VJMJtIO3jkNEIgquOYSYswElpE2y+p6K1G2w3qx9a
         vHzalNUd4/ce+fNAFM9ew0cUAaYwXdaT7T/4RBpsBetxezbBROW5xSANHjO2yCFfkBlh
         KFXLN06sOFCjngr/M7tpixJTlgpRTFjmra+UX+H3LOpda2P9Ud62u1YWtasFnZRkH8c0
         H4dHKiQ82Evx3M5gb0aOJhvNIppom9uWGyj/SdwiRq01d/2iKnhNNKdfWdwPXxaB9bi6
         3iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742756883; x=1743361683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzd5n04s6jxEJ+gCSK/dDhucMnvX+2uhB2qdLifXWko=;
        b=uZ0t9kNRezj/+Fp6SQ3Te0p/LDfawdNjeVIXqPVtNlJkaugKWpbf2UwYxk9mA6OsG4
         ZJUy2DrfcURZ72c9bAAhKqjmc83khrzo7wBi/TTRlYv+bnFM6Md1jz4ZrjRF7W3fT/ZL
         6y1H0DK+5uyn6zoqZk4VPB02N6tsXVqQgNrE6/u4cj86xt589zioh9UbkifyEFgi0Sl7
         xKaHU25Y/sJOEXnQtaio/CC8OoDkwfyHXE/hyW9bVdGm44KJFkgwtd3azsLLh8K59M5F
         klajU54y3dLKDgPsTottiwSuUr5du14FyNrk68nLWL8rVL06s6TzMp3e87i/51zxeII8
         vq9w==
X-Forwarded-Encrypted: i=1; AJvYcCVZmPLuoQZz+u3xIbwhcvEJOdUHvfkUpthO8/o1WNdX09AFPGdlPU7wSgDyzX6ZlAAwlLPOXsn0rQk/Nhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVk9vSE+NQTrfWMaQ1mlZa72y6cCTAUWI5bt/thhseRc7eHVJ6
	g3AiXoARlrvXdlg4IXqtJ+BcZ4F6ma5aB6IA9PQxqP04QMgYYMfcPuyur8OdbZAFBx/Qm7aytQ3
	2z+j7QnEO/GF/jdpguQ==
X-Google-Smtp-Source: AGHT+IGWzYSY0zabXCYcrGJkQenZmyCPMKhLyeRtNYw0Z+Vw+fyMnZoqvv9CAHyz7l26vGknvFW4powxBM9q/JtU
X-Received: from plri3.prod.google.com ([2002:a17:903:32c3:b0:220:e84e:350c])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id d9443c01a7336-22780e2a37fmr150656275ad.49.1742756882709;
 Sun, 23 Mar 2025 12:08:02 -0700 (PDT)
Date: Sun, 23 Mar 2025 12:07:58 -0700
In-Reply-To: <20250321134629.GA252045@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321134629.GA252045@nvidia.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250323190758.743798-1-changyuanl@google.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
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

On Fri, Mar 21, 2025 at 10:46:29 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Wed, Mar 19, 2025 at 06:55:44PM -0700, Changyuan Lyu wrote:
> > +/**
> > + * kho_preserve_folio - preserve a folio across KHO.
> > + * @folio: folio to preserve
> > + *
> > + * Records that the entire folio is preserved across KHO. The order
> > + * will be preserved as well.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int kho_preserve_folio(struct folio *folio)
> > +{
> > +	unsigned long pfn = folio_pfn(folio);
> > +	unsigned int order = folio_order(folio);
> > +	int err;
> > +
> > +	if (!kho_enable)
> > +		return -EOPNOTSUPP;
> > +
> > +	down_read(&kho_out.tree_lock);
> > +	if (kho_out.fdt) {
>
> What is the lock and fdt test for?

It is to avoid the competition between the following 2 operations,
- converting the hashtables and mem traker to FDT,
- adding new data to hashtable/mem tracker.
Please also see function kho_finalize() in the previous patch
"kexec: add Kexec HandOver (KHO) generation helpers" [1].

The function kho_finalize() iterates over all the hashtables and
the mem tracker. We want to make sure that during the iterations,
no new data is added to the hashtables and mem tracker.

Also if FDT is generated, the mem tracker then has been serialized
to linked pages, so we return -EBUSY to prevent more data from
being added to the mem tracker.

> I'm getting the feeling that probably kho_preserve_folio() and the
> like should accept some kind of
> 'struct kho_serialization *' and then we don't need this to prove we
> are within a valid serialization window. It could pass the pointer
> through the notifiers

If we use notifiers, callbacks have to be done serially.

> The global variables in this series are sort of ugly..
>
> We want this to be fast, so try hard to avoid a lock..

In most cases we only need read lock. Different KHO users can adding
data into their own subnodes in parallel.
We only need a write lock if
- 2 KHO users register subnodes to the KHO root node at the same time
- KHO root tree is about to be converted to FDT.

> > +void *kho_restore_phys(phys_addr_t phys, size_t size)
> > +{
> > +	unsigned long start_pfn, end_pfn, pfn;
> > +	void *va = __va(phys);
> > +
> > +	start_pfn = PFN_DOWN(phys);
> > +	end_pfn = PFN_UP(phys + size);
> > +
> > +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > +		struct page *page = pfn_to_online_page(pfn);
> > +
> > +		if (!page)
> > +			return NULL;
> > +		kho_restore_page(page);
> > +	}
> > +
> > +	return va;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_restore_phys);
>
> What do you imagine this is used for? I'm not sure what value there is
> in returning a void *? How does the caller "free" this?

This function is also from Mike :)

I suppose some KHO users may still
preserve memory using memory ranges (instead of folio). In the restoring
stage they need a helper to setup the pages of reserved memory ranges.
A void * is returned so the KHO user can access the memory
contents through the virtual address.
I guess the caller can free the ranges by free_pages()?

It makes sense to return nothing and let caller to call `__va`
if they want. Then the function signature looks more symmetric to
`kho_preserve_phys`.

> > +#define KHOSER_PTR(type)          \
> > +	union {                   \
> > +		phys_addr_t phys; \
> > +		type ptr;         \
> > +	}
> > +#define KHOSER_STORE_PTR(dest, val)                 \
> > +	({                                          \
> > +		(dest).phys = virt_to_phys(val);    \
> > +		typecheck(typeof((dest).ptr), val); \
> > +	})
> > +#define KHOSER_LOAD_PTR(src) \
> > +	((src).phys ? (typeof((src).ptr))(phys_to_virt((src).phys)) : NULL)
>
> I had imagined these macros would be in a header and usably by drivers
> that also want to use structs to carry information.
>

OK I will move them to the header file in the next version.

> > [...]
> > @@ -829,6 +1305,10 @@ static __init int kho_init(void)
> >
> >  	kho_out.root.name = "";
>
> ?

Set the root node name to an empty string since fdt_begin_node
calls strlen on the node name.

It is equivalent to `err = fdt_begin_node(fdt, "")` in kho_serialize()
of Mike's V4 patch [2].

> >  	err = kho_add_string_prop(&kho_out.root, "compatible", "kho-v1");
> > +	err |= kho_add_prop(&kho_out.preserved_memory, "metadata",
> > +			    &kho_out.first_chunk_phys, sizeof(phys_addr_t));
>
> metedata doesn't fee like a great a better name..
>
> Please also document all the FDT schema thoroughly!
>
> There should be yaml files just like in the normal DT case defining
> all of this. This level of documentation and stability was one of the
> selling reasons why FDT is being used here!

YAML files were dropped because we think it may take a while for our
schema to be near stable. So we start from some simple plain text. We
can add some prop and node docs (that are considered stable at this point)
back to YAML in the next version.

[1] https://lore.kernel.org/all/20250320015551.2157511-8-changyuanl@google.com/
[2] https://lore.kernel.org/all/20250206132754.2596694-6-rppt@kernel.org/

Best,
Changyuan

