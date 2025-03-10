Return-Path: <linux-kernel+bounces-554137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F2A59360
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFFA7A2377
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6202253A5;
	Mon, 10 Mar 2025 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="fWZtyGmN"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F51A314B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608263; cv=none; b=d0m546QJUJNnwVmuDyA+/56ofhSNQHCqRSAX0HwzB1sWeoJ65zrtKFcNWOP9+yBx8VxZybXoTYT5P6CFmSk4IO/bK7sNFwRqImmL7LYvDFMaRbNXzofoxIJqywNpTnTsR6BEX2A1aUkA0Saf21IC/dPxq7uSrpxpeEKQA5PlkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608263; c=relaxed/simple;
	bh=Bn0ajlg1udmn5GMH7s6qm/cx0Mnvp5I2mJJZdEL+VH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZRvH2WXz24bUVQfIgv0toELsAGHHXBThEIXwqsK5cgS6dEL11/EgLbmmP8Qv3tOCXNajQND9XVY6bsJm30GKMRGN25ZZN9VtlKMlKakt6nAux0s6x8I2RnIw0Qi/INysUQWycGpTK5xRshStgHZaPoGPqrJpSv3YlLuMSHcrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=fWZtyGmN; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7B72A60EBA;
	Mon, 10 Mar 2025 15:04:01 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-Kq6zF6NZ;
	Mon, 10 Mar 2025 15:04:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608240;
	bh=XKHgnvQxGKjJqIO37SYW6qMo+hh+Xx+yeaCwPWU001c=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fWZtyGmNAf3TxCVO6cR1CGphoTpFv46TB+NUDs4zpbDUeTVIZKTYFlC+LQ+ien5GU
	 QI0RVRKypVgBFhNPJDMiHCF41YTWhLaWzJdRGjVMxU/odm0o51V6JYFmZE/A+JZxL7
	 1txeZtvXpPp4GDHbsTI1J0q25oF/V39ygtwGEZGk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the kernel state across kexec
Date: Mon, 10 Mar 2025 13:03:11 +0100
Message-ID: <20250310120318.2124-1-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Main changes from v1 [1]:
  - Get rid of abusing crashkernel and implent proper way to pass memory to new kernel
  - Lots of misc cleanups/refactorings.

kstate (kernel state) is a mechanism to describe internal some part of the
kernel state, save it into the memory and restore the state after kexec
in the new kernel.

The end goal here and the main use case for this is to be able to
update host kernel under VMs with VFIO pass-through devices running
on that host. Since we are pretty far from that end goal yet, this
only establishes some basic infrastructure to describe and migrate complex
in-kernel states.

The idea behind KSTATE resembles QEMU's migration framework [1], which
solves quite similar problem - migrate state of VM/emulated devices
across different versions of QEMU.

This is an altenative to Kexec Hand Over (KHO [3]).

So, why not KHO?

 - The main reason is KHO doesn't provide simple and convenient internal
    API for the drivers/subsystems to preserve internal data.
    E.g. lets consider we have some variable of type 'struct a'
    that needs to be preserved:
	struct a {
	        int i;
        	unsigned long *p_ulong;
	        char s[10];
        	struct page *page;
	};

     The KHO-way requires driver/subsystem to have a bunch of code
     dealing with FDT stuff, something like

     a_kho_write()
     {
	     ...
	     fdt_property(fdt, "i", &a.i, sizeof(a.i));
	     fdt_property(fdt, "ulong", a.p_ulong, sizeof(*a.p_ulong));
	     fdt_property(fdt, "s", &a.s, sizeof(a.s));
	     if (err)
	     ...
     }
     a_kho_restore()
     {
             ...
     	     a.i = fdt_getprop(fdt, offset, "i", &len);
	     if (!a.i || len != sizeof(a.i))
	     	goto err
	     *a.p_ulong = fdt_getprop....
     }

    Each driver/subsystem has to solve this problem in their own way.
    Also if we use fdt properties for individual fields, that might be wastefull
    in terms of used memory, as these properties use strings as keys.

   While with KSTATE solves the same problem in more elegant way, with this:
	struct kstate_description a_state = {
        	.name = "a_struct",
	        .version_id = 1,
        	.id = KSTATE_TEST_ID,
	        .state_list = LIST_HEAD_INIT(test_state.state_list),
        	.fields = (const struct kstate_field[]) {
                	KSTATE_BASE_TYPE(i, struct a, int),
	                KSTATE_BASE_TYPE(s, struct a, char [10]),
        	        KSTATE_POINTER(p_ulong, struct a),
                	KSTATE_PAGE(page, struct a),
	                KSTATE_END_OF_LIST()
        	},
	};


	{
		static unsigned long ulong
		static struct a a_data = { .p_ulong = &ulong };

		kstate_register(&test_state, &a_data);
	}

       The driver needs only to have a proper 'kstate_description' and call kstate_register()
       to save/restore a_data.
       Basically 'struct kstate_description' provides instructions how to save/restore 'struct a'.
       And kstate_register() does all this save/restore stuff under the hood.

 - Another bonus point - kstate can preserve migratable memory, which is required
    to preserve guest memory


So now to the part how this works.

State of kernel data (usually it's some struct) is described by the
'struct kstate_description' containing the array of individual
fields descpriptions - 'struct kstate_field'. Each field
has set of bits in ->flags which instructs how to save/restore
a certain field of the struct. E.g.:
  - KS_BASE_TYPE flag tells that field can be just copied by value,

  - KS_POINTER means that the struct member is a pointer to the actual
     data, so it needs to be dereference before saving/restoring data
     to/from kstate data steam.

  - KS_STRUCT - contains another struct,  field->ksd must point to
      another 'struct kstate_dscription'

  - KS_CUSTOM - Some non-trivial field that requires custom kstate_field->save()
               ->restore() callbacks to save/restore data.

  - KS_ARRAY_OF_POINTER - array of pointers, the size of array determined by the
                         field->count() callback
  - KS_ADDRESS - field is a pointer to either vmemmap area (struct page) or
     linear address. Store offset

  - KS_END - special flag indicating the end of migration stream data.

kstate_register() call accepts kstate_description along with an instance
of an object and registers it in the global 'states' list.

During kexec reboot phase we go through the list of 'kstate_description's
and each instance of kstate_description forms the 'struct kstate_entry'
which save into the kstate's data stream.

The 'kstate_entry' contains information like ID of kstate_description, version
of it, size of migration data and the data itself. The ->data is formed in
accordance to the kstate_field's of the corresponding kstate_description.

After the reboot, when the kstate_register() called it parses migration
stream, finds the appropriate 'kstate_entry' and restores the contents of
the object in accordance with kstate_description and ->fields.

 [1] https://lkml.kernel.org/r/20241002160722.20025-1-arbn@yandex-team.com
 [2] https://www.qemu.org/docs/master/devel/migration/main.html#vmstate
 [3] https://lkml.kernel.org/r/20250206132754.2596694-1-rppt@kernel.org

Andrey Ryabinin (7):
  kstate: Add kstate - a mechanism to describe and migrate kernel state
    across kexec
  kstate, kexec, x86: transfer kstate data across kexec
  kexec: exclude control pages from the destination addresses
  kexec, kstate: delay loading of kexec segments
  x86, kstate: Add the ability to preserve memory pages across kexec.
  kexec, kstate: save kstate data before kexec'ing
  kstate, test: add test module for testing kstate subsystem.

 arch/x86/Kconfig                  |   1 +
 arch/x86/kernel/kexec-bzimage64.c |   4 +
 arch/x86/kernel/setup.c           |   2 +
 include/linux/kexec.h             |   3 +
 include/linux/kstate.h            | 216 ++++++++++++++
 kernel/Kconfig.kexec              |  13 +
 kernel/Makefile                   |   1 +
 kernel/kexec_core.c               |  30 ++
 kernel/kexec_file.c               | 159 +++++++----
 kernel/kexec_internal.h           |   9 +
 kernel/kstate.c                   | 458 ++++++++++++++++++++++++++++++
 lib/Makefile                      |   2 +
 lib/test_kstate.c                 |  86 ++++++
 13 files changed, 925 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/kstate.h
 create mode 100644 kernel/kstate.c
 create mode 100644 lib/test_kstate.c

-- 
2.45.3


