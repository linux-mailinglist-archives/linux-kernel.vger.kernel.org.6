Return-Path: <linux-kernel+bounces-385519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32279B381F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B793B282DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79AE1E009F;
	Mon, 28 Oct 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJAPJYWs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB641DFE1E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137368; cv=none; b=smzXYY29p0kVQIYiXRRZUToczLPwStb2hyO7AWQgUkWhHA8CcdMoFnRjVPLpouhHqHGBPeLVLHjeivZPVJJbsvGHA72q35D4vtp0karFIEyQ1xmIWplgIDtKVvNPz5UGV9pioYWe5AwJh5htGtgLDA6Sb/1LOHnK1r6XR5nVrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137368; c=relaxed/simple;
	bh=qifG2s2osTQGjgqZ2d+3qLjvf/bfWrwNq7VRR/uozC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkauUy7+cb+GamzcJURyD0ud7xv3EqG8E4RfjGMfIZaATAbB0mdl20Vjtw9clpfnyv9JY01fAKu7/QLJCfdWkS4Bf/lBGQ63GaQ1ZDJOdoS4PCMzsGXEzcDPCcDT6i88/vgF8DN8+2twb8+uF59kNbyFe4jkiSW16s7FPRUGE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJAPJYWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730137365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qifG2s2osTQGjgqZ2d+3qLjvf/bfWrwNq7VRR/uozC0=;
	b=GJAPJYWs1r/mXltNPQFWqdpvJh96uYHnwZn83onnwZu8iozz3KhIMTi/QbOROdV5KUs0zm
	AYS1WLfJ9suDmNMI4L/ir4MLJ6GKQ7g9u70LFcRLG7SrsFc1OcTB0VBAOzJTmlTe8Fwuoh
	zqi5/SJy93GTreqqy4xDYv5sBVAHxGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-MEJPExR_MNmOqVNg6Gg9Yg-1; Mon,
 28 Oct 2024 13:42:40 -0400
X-MC-Unique: MEJPExR_MNmOqVNg6Gg9Yg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 920691955BF6;
	Mon, 28 Oct 2024 17:42:37 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F82F300019B;
	Mon, 28 Oct 2024 17:42:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kai Huang <kai.huang@intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	reinette.chatre@intel.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	adrian.hunter@intel.com,
	tony.lindgren@intel.com,
	kristen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: VMX: Initialize TDX when loading KVM module
Date: Mon, 28 Oct 2024 13:41:51 -0400
Message-ID: <20241028174150.301507-2-pbonzini@redhat.com>
In-Reply-To: <cover.1730120881.git.kai.huang@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

> This series contains patches to initialize TDX when loading KVM module.
> This series is based on the discussion with Sean on the v19 patchset
> [*], hoping it has addressed most (if not all) comments.
>
> This series has been in our internal TDX tree for long time and has been
> in kvm-coco-queue for some time thus it has been tested.
>
> The main purpose for sending out is to have a review but this series can
> also be applied to kvm/queue cleanly.

Thanks, I'll replace the commits in kvm-coco-queue so that it tracks
the posting to the mailing list.

Paolo


