Return-Path: <linux-kernel+bounces-310265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC6967736
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F61C20AC4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6E17DFE9;
	Sun,  1 Sep 2024 15:35:54 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651D26AEA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725204954; cv=none; b=d4nzz7jTEKQnmv8XsiH7wzMvCSKa32FBlq/e52UHru6b4X+iSjUL/l/mw+tShfkJdQ/AwdcSozurwEZ3qacJYcvKidJozIuzuQ7wpy34un1OMyXIgMFfP2wssEaTaGXgipdn0EgfjaZeT/0v2Rg60ZLGGpN97QADDtRgKpXfd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725204954; c=relaxed/simple;
	bh=r0jNTiLoecJKnnJ5CdEjUz5HO/hYdmcflEzyAlCsozI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR3QsABVZupz6XGYPq3NgXJdFia3faZSoGh1NfteXMrAVA7xaNMYPvW38bHH+xZdcZeroHyCzVbabTqrE80wdvg4lellDz7aBwm+VhxPNM6/cQNsaKi1tXRmXDvfUSD2C6+RLB0CYxW5mx4VT6q+tqxR0dlDKbZvAZx2NrevQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f645a30dcso1976429a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 08:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725204951; x=1725809751;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPcffN6Y0/nsSLxwxfe0IvDd6h+tZoZCfUXmpqQ5Un4=;
        b=DihK9sfqxPhA9w85EqN2jb0pzFT6NO9EW0o9QDaSY4RzdXffiBQ0eamzpmjAwn6Xet
         QN5tS3eqdNwj4L1K8VMAygba+ZPgixvZjzAUZ3Qk7XNbzTIP/2MeVknXt7hGJ2zZfJbc
         6VNt2aFZTG8cbm01iBgk3UFxe/pMsmeO14+6Q7cOfpX99AOL4eZOt63lbuFGR+aG068A
         mjg1onufZesEPkkEEGc5iUwZp7ttiu7PHjebkDBtcl8I9grkHDbKrw0q9p2OMVrDaQUS
         YOu9+wOHgKnMHSrkG2iU+AgZr7lEdhUi9+F3IBRI1v4dcNBA6woI5V3IzvNMZ9IbM2sv
         6+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEbtQQC+Q13KsX7R2cU+IhaZri1/FPtRgaNdI2UatbXEksHGAXfiPZ6ZhdqPAUlHZxfvlRsFcyUdmAyIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDrJRa01F1XCA6RGJfcPhzwH7id4SB1NWmnbh/p90bc6gqRtJ
	dPPCFrJBx1tP9sQKd6eTfpjvwpO0oQHAtwt3B5IyOtU3WOUGqyjr
X-Google-Smtp-Source: AGHT+IFIdYznnLs5Fw0SlKIYzk1/n5ESuMS8FBoKloYIpmwTHi/w9VgrmaOJR3TipQDbsxj+aIbL7g==
X-Received: by 2002:a05:6830:2905:b0:703:7821:da7 with SMTP id 46e09a7af769-70f5c3fbf75mr13863415a34.25.1725204951291;
        Sun, 01 Sep 2024 08:35:51 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c362e23487sm5972916d6.117.2024.09.01.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 08:35:50 -0700 (PDT)
Date: Sun, 1 Sep 2024 10:35:48 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched_ext: Fix processs_ddsp_deferred_locals() by
 unifying DTL_INVALID handling
Message-ID: <20240901153548.GK70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-5-tj@kernel.org>
 <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
 <20240901005337.GD70166@maniforge>
 <20240901005639.GE70166@maniforge>
 <ZtQf7jPR3He48jLH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRQN9mrpzsXEUd+R"
Content-Disposition: inline
In-Reply-To: <ZtQf7jPR3He48jLH@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--ZRQN9mrpzsXEUd+R
Content-Type: multipart/mixed; boundary="PtTDoeNoVytaOQZP"
Content-Disposition: inline


--PtTDoeNoVytaOQZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:03:58PM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Sat, Aug 31, 2024 at 07:56:39PM -0500, David Vernet wrote:
> ...
> > Sorry, should have been more clear: the testcase dispatched all tasks to
> > the wrong CPU, which is why it's a kworker in the print output below. I
> > believe that ksoftiqrd hit the same path as well and just wasn't printed
> > in the output because it lost the race to scx_bpf_error(). Let me know
> > if you want the testcase to repro and I can send it, or send a separate
> > patch to add it to selftests.
>=20
> Yeah, please share the repro.

See the attached patch. You can run the test as follows after rebuilding
selftests:

=2E/runner -t ddsp_local_on_invalid

You may have to run the test a few times to see the repro. Worth noting
is that the repro doesn't seem to hit if we don't explicitly set the
fallback target to 0 in ddsp_local_on_invalid_enqueue().

Thanks,
David

--PtTDoeNoVytaOQZP
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-scx-Add-test-validating-direct-dispatch-with-LOCAL_O.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 5e1a850b7db989429b94ea5d9cdf786faf3bcd4f Mon Sep 17 00:00:00 2001
=46rom: David Vernet <void@manifault.com>
Date: Sat, 31 Aug 2024 19:16:22 -0500
Subject: [PATCH] scx: Add test validating direct dispatch with LOCAL_ON

SCX_DSQ_LOCAL_ON | cpu can now be invoked on the direct dispatch path.
Let's ensure we're gracefully handling it being dispatched to a CPU
that it's not allowed to run on.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../sched_ext/ddsp_local_on_invalid.bpf.c     | 42 ++++++++++++++
 .../sched_ext/ddsp_local_on_invalid.c         | 58 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_local_on_invalid=
=2Ebpf.c
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_local_on_invalid=
=2Ec

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/sel=
ftests/sched_ext/Makefile
index 0754a2c110a1..4823a67e6854 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -165,6 +165,7 @@ auto-test-targets :=3D			\
 	enq_last_no_enq_fails		\
 	enq_select_cpu_fails		\
 	ddsp_bogus_dsq_fail		\
+	ddsp_local_on_invalid		\
 	ddsp_vtimelocal_fail		\
 	dsp_local_on			\
 	exit				\
diff --git a/tools/testing/selftests/sched_ext/ddsp_local_on_invalid.bpf.c =
b/tools/testing/selftests/sched_ext/ddsp_local_on_invalid.bpf.c
new file mode 100644
index 000000000000..e4512d7cc4b5
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_local_on_invalid.bpf.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") =3D "GPL";
+const volatile s32 nr_cpus;
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(ddsp_local_on_invalid_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(ddsp_local_on_invalid_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	int target =3D bpf_cpumask_first_zero(p->cpus_ptr);
+
+	if (target >=3D nr_cpus)
+		target =3D 0;
+
+	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(ddsp_local_on_invalid_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops ddsp_local_on_invalid_ops =3D {
+	.select_cpu		=3D ddsp_local_on_invalid_select_cpu,
+	.enqueue		=3D ddsp_local_on_invalid_enqueue,
+	.exit			=3D ddsp_local_on_invalid_exit,
+	.name			=3D "ddsp_local_on_invalid",
+	.timeout_ms		=3D 2000U,
+};
diff --git a/tools/testing/selftests/sched_ext/ddsp_local_on_invalid.c b/to=
ols/testing/selftests/sched_ext/ddsp_local_on_invalid.c
new file mode 100644
index 000000000000..7bc49df06ee0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_local_on_invalid.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "ddsp_local_on_invalid.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct ddsp_local_on_invalid *skel;
+
+	skel =3D ddsp_local_on_invalid__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+
+	skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
+	SCX_FAIL_IF(ddsp_local_on_invalid__load(skel), "Failed to load skel");
+	*ctx =3D skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct ddsp_local_on_invalid *skel =3D ctx;
+	struct bpf_link *link;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ddsp_local_on_invalid_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct ddsp_local_on_invalid *skel =3D ctx;
+
+	ddsp_local_on_invalid__destroy(skel);
+}
+
+struct scx_test ddsp_local_on_invalid =3D {
+	.name =3D "ddsp_local_on_invalid",
+	.description =3D "Verify we can gracefully handle direct dispatch "
+		       "of tasks to an invalid local DSQ from osp.dispatch()",
+	.setup =3D setup,
+	.run =3D run,
+	.cleanup =3D cleanup,
+};
+REGISTER_SCX_TEST(&ddsp_local_on_invalid)
--=20
2.45.2


--PtTDoeNoVytaOQZP--

--ZRQN9mrpzsXEUd+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtSJ1AAKCRBZ5LhpZcTz
ZFRkAQDuXEod0j/ysAspCxOmxoio+cmkJgvF7EQtU5iE9AnSVAD+JCIW9M4loy9l
n162Mdod9OxQ1wDZAAYNfXIIIoz9zgo=
=fzZT
-----END PGP SIGNATURE-----

--ZRQN9mrpzsXEUd+R--

