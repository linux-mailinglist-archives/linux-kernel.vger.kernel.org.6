Return-Path: <linux-kernel+bounces-534650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF15A4697E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8052917404A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3E7261384;
	Wed, 26 Feb 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJQNMXXf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965325D542
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593747; cv=none; b=LxmlugNpdlN9VGpLtD3PTWYOpGWyPADbWbjWGUBQmFM9J1FW5AqZq7RbrwGAhTidSbiEzjTkl9gd5iYspHQXi5Vg6DwEwZL1P6kWn2UDbo+IMtyznGRhYNPeOQqqcSu3oO2ds2/OiONnfwSytgIfWldFYHkQTr0akhkNCWLdfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593747; c=relaxed/simple;
	bh=NBdunC5lJ/0wDxjemQIcY8rtalIes4o07ZV/XLMIl1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNgUJvi98zPDEOu1O7zPdgza4ZDmNt9FiXEOD2OQW0nEwrmzRMBcKsislEnS5MB9kCqK2KCp6mhOqTZpS11OR+nU9eJeP+VpLThrCiTEaT1fTLXW+Zt2JtN4vXqQxKavQmagxibeaVxnEpaMPmpIyoJPrhMYZkE0RSemxd6P4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJQNMXXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740593744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5/36DOYHjQnzo6/HvctVz+uhV8riaYpDjq/buYd1gM=;
	b=XJQNMXXffqhuCfnh56Db8xuEuX/Xou1E69vjkKAiMJHwvSojzdUaSZKfmfn8Op6sy5M5j4
	V+9He+Ya1SQSxWrv27j4zhjGkwzn06WZcidoY0BLJr41LzPFzFy3joC2qjymIixbArNqz4
	18jdI1fOyrtZaRXiGqoP+f57MGWVOhE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-0FjGuvR4NNeg01nqSsX79g-1; Wed,
 26 Feb 2025 13:15:38 -0500
X-MC-Unique: 0FjGuvR4NNeg01nqSsX79g-1
X-Mimecast-MFC-AGG-ID: 0FjGuvR4NNeg01nqSsX79g_1740593736
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79DDC18EB2CE;
	Wed, 26 Feb 2025 18:15:36 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4569819560AE;
	Wed, 26 Feb 2025 18:15:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH 28/33] KVM: TDX: Don't offline the last cpu of one package when there's TDX guest
Date: Wed, 26 Feb 2025 13:14:47 -0500
Message-ID: <20250226181453.2311849-29-pbonzini@redhat.com>
In-Reply-To: <20250226181453.2311849-1-pbonzini@redhat.com>
References: <20250226181453.2311849-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Isaku Yamahata <isaku.yamahata@intel.com>

Destroying TDX guest requires there's at least one cpu online for each
package, because reclaiming the TDX KeyID of the guest (as part of the
teardown process) requires to call some SEAMCALL (on any cpu) on all
packages.

Do not offline the last cpu of one package when there's any TDX guest
running, otherwise KVM may not be able to teardown TDX guest resulting
in leaking of TDX KeyID and other resources like TDX guest control
structure pages.

Implement the TDX version 'offline_cpu()' to prevent the cpu from going
offline if it is the last cpu on the package.

Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/tdx.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1d1bdc70f4ae..0c1de3cbd45a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -131,10 +131,13 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
  */
 static DEFINE_MUTEX(tdx_lock);
 
+static atomic_t nr_configured_hkid;
+
 static inline void tdx_hkid_free(struct kvm_tdx *kvm_tdx)
 {
 	tdx_guest_keyid_free(kvm_tdx->hkid);
 	kvm_tdx->hkid = -1;
+	atomic_dec(&nr_configured_hkid);
 }
 
 static inline bool is_hkid_assigned(struct kvm_tdx *kvm_tdx)
@@ -603,6 +606,8 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
+	atomic_inc(&nr_configured_hkid);
+
 	tdr_page = alloc_page(GFP_KERNEL);
 	if (!tdr_page)
 		goto free_hkid;
@@ -899,6 +904,42 @@ static int tdx_online_cpu(unsigned int cpu)
 	return r;
 }
 
+static int tdx_offline_cpu(unsigned int cpu)
+{
+	int i;
+
+	/* No TD is running.  Allow any cpu to be offline. */
+	if (!atomic_read(&nr_configured_hkid))
+		return 0;
+
+	/*
+	 * In order to reclaim TDX HKID, (i.e. when deleting guest TD), need to
+	 * call TDH.PHYMEM.PAGE.WBINVD on all packages to program all memory
+	 * controller with pconfig.  If we have active TDX HKID, refuse to
+	 * offline the last online cpu.
+	 */
+	for_each_online_cpu(i) {
+		/*
+		 * Found another online cpu on the same package.
+		 * Allow to offline.
+		 */
+		if (i != cpu && topology_physical_package_id(i) ==
+				topology_physical_package_id(cpu))
+			return 0;
+	}
+
+	/*
+	 * This is the last cpu of this package.  Don't offline it.
+	 *
+	 * Because it's hard for human operator to understand the
+	 * reason, warn it.
+	 */
+#define MSG_ALLPKG_ONLINE \
+	"TDX requires all packages to have an online CPU. Delete all TDs in order to offline all CPUs of a package.\n"
+	pr_warn_ratelimited(MSG_ALLPKG_ONLINE);
+	return -EBUSY;
+}
+
 static void __do_tdx_cleanup(void)
 {
 	/*
@@ -931,7 +972,7 @@ static int __init __do_tdx_bringup(void)
 	 */
 	r = cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
 					 "kvm/cpu/tdx:online",
-					 tdx_online_cpu, NULL);
+					 tdx_online_cpu, tdx_offline_cpu);
 	if (r < 0)
 		return r;
 
-- 
2.43.5



