Return-Path: <linux-kernel+bounces-290176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9495504D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA731F27079
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785071C3F34;
	Fri, 16 Aug 2024 17:54:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556A1C3F2F;
	Fri, 16 Aug 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830862; cv=none; b=EsM3ZBcbiVRQjT1zmaRJD3BiI1dmT9IsYNjr9AdUdzBCO1wKei08Nuh5LNRjiOt1TAcmBzY9bimCnGV9hiYSPqrVeMBX7xedqj7EO7U9gUz4GR/IT00cpZtB9Jnkre1PGDhybfolY2ibOWb/3yq9neNEnBIZFrJrMCWdVrdOtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830862; c=relaxed/simple;
	bh=21bmq1wZojonL5BW0KyWR9WylEzTTKYZDupzBC5feD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok4rveaZbnY49Rddq++k531qBlpK2JYMCz5glYLDwsa826ptJPDIM5QSdHSvDVkGctjZnu5sdQH44w+HfqYfwpj7PJSju54TkAR/tolTukXhK4CORSCk/sDTICHGMD6DLpRr72Df00ZypYvpZcEVjYXV/GNTz/noT5vIq6WisOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC8113D5;
	Fri, 16 Aug 2024 10:54:44 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDC83F6A8;
	Fri, 16 Aug 2024 10:54:16 -0700 (PDT)
Date: Fri, 16 Aug 2024 18:54:14 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <Zr-SRo10QtSh4G9R@pluto>
References: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
 <20240813180747.1439034-3-florian.fainelli@broadcom.com>
 <Zr-GJts3Gu6GEkhC@pluto>
 <345aca0f-12f0-4a66-a760-3b8524fda7fe@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345aca0f-12f0-4a66-a760-3b8524fda7fe@broadcom.com>

On Fri, Aug 16, 2024 at 10:39:42AM -0700, Florian Fainelli wrote:
> On 8/16/24 10:02, Cristian Marussi wrote:
> > On Tue, Aug 13, 2024 at 11:07:47AM -0700, Florian Fainelli wrote:
> > > Some shared memory areas might only support a certain access width,
> > > such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> > > on ARM64 by making both 8-bit and 64-bit accesses to such memory.
> > > 
> > > Update the shmem layer to support reading from and writing to such
> > > shared memory area using the specified I/O width in the Device Tree. The
> > > various transport layers making use of the shmem.c code are updated
> > > accordingly to pass the I/O accessors that they store.
> > > 
> > 
> > Hi Florian,
> > 

Hi,

> > I gave it ago at this on a JUNO regarding the mailbox/shmem transport
> > without any issue. I'll have a go later on an OPTEE/shmem scenario too.
> > 
> > This looks fundamentally good to me, since you moved all ops setup at
> > setup time and you keep the pointers per-channel instead of global...
> 
> Thanks!
>

[snip]
 
> > > +
> > 
> > There are a bunch of warn/errs from checkpatch --strict, beside the volatile
> > here and on the previous typedefs, also about args reuse and trailing semicolon
> > in these macros...
> 
> I don't think we can silence the volatile ones, checkpatch --strict did not
> complain about the typedefs in my case, what did it look like in yours?

...I dont get warns on new typedefs..only on volatile and macro args
reuse


---8<---

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#36: FILE: drivers/firmware/arm_scmi/common.h:322:
+typedef void (*shmem_copy_toio_t)(volatile void __iomem *to, const void *from,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#38: FILE: drivers/firmware/arm_scmi/common.h:324:
+typedef void (*shmem_copy_fromio_t)(void *to, const volatile void __iomem *from,

CHECK: Macro argument reuse 'amt' - possible side-effects?
#94: FILE: drivers/firmware/arm_scmi/shmem.c:37:
+#define SHMEM_IO_OPS(w, s, amt)						\
+static inline void shmem_memcpy_fromio##s(void *to,			\
+					  const volatile void __iomem *from, \
+					  size_t count)			\
+{									\
+	while (count) {							\
+		*(u##s *)to = __raw_read##w(from);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static inline void shmem_memcpy_toio##s(volatile void __iomem *to,	\
+					const void *from,		\
+					size_t count)			\
+{									\
+	while (count) {							\
+		__raw_write##w(*(u##s *)from, to);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static struct scmi_shmem_io_ops shmem_io_ops##s = {			\
+	.fromio	= shmem_memcpy_fromio##s,				\
+	.toio	= shmem_memcpy_toio##s,					\
+};

WARNING: macros should not use a trailing semicolon
#94: FILE: drivers/firmware/arm_scmi/shmem.c:37:
+#define SHMEM_IO_OPS(w, s, amt)						\
+static inline void shmem_memcpy_fromio##s(void *to,			\
+					  const volatile void __iomem *from, \
+					  size_t count)			\
+{									\
+	while (count) {							\
+		*(u##s *)to = __raw_read##w(from);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static inline void shmem_memcpy_toio##s(volatile void __iomem *to,	\
+					const void *from,		\
+					size_t count)			\
+{									\
+	while (count) {							\
+		__raw_write##w(*(u##s *)from, to);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static struct scmi_shmem_io_ops shmem_io_ops##s = {			\
+	.fromio	= shmem_memcpy_fromio##s,				\
+	.toio	= shmem_memcpy_toio##s,					\
+};

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#96: FILE: drivers/firmware/arm_scmi/shmem.c:39:
+					  const volatile void __iomem *from, \

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#106: FILE: drivers/firmware/arm_scmi/shmem.c:49:
+static inline void shmem_memcpy_toio##s(volatile void __iomem *to,	\

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#128: FILE: drivers/firmware/arm_scmi/shmem.c:71:
+				       const volatile void __iomem *from,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#134: FILE: drivers/firmware/arm_scmi/shmem.c:77:
+static inline void shmem_memcpy_toio(volatile void __iomem *to,

total: 0 errors, 7 warnings, 1 checks, 312 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] firmware: arm_scmi: Support 'reg-io-width' property for" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

---8<----


