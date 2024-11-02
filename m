Return-Path: <linux-kernel+bounces-393298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94139B9EC8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F12281B61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3A170A19;
	Sat,  2 Nov 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="cDhFhCWg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBdcuDIb"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B33168DA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542524; cv=none; b=rqx0iMWlAUjgr6MSYh9Ei7fIBYuoT6ADANbT4Zj+V3DQygef0p3KkMt/GCHa3Gm46Eo0K0j93kGdTV6Ofwq8SxxtaF0dJIU/tG9hTW/a/k3UqByH4IrIRPagqPO/WpKssA+aTm1kav7K3Zfv/+qZKhXd29ECzkw1oshoX6FVDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542524; c=relaxed/simple;
	bh=OWWDd+9HdGNESPSKb2s7WqI4gVoccQhBa/YTGEXqjjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AZO0J9j+otQsCl5FN6kLhoaBBtv1PnBNdbxil4apniJx5SOeSaRZHhAaqdTpau5YDluJTvqgqMQqhctr2S1Mh7caIohoVFrOoPDcW1NFSf3r6qUESuPv+vMvF1kb2iQ7QRU9IbtG463t6cKsQtaSF4cqtE3/tYYjUXKnXnTHj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=cDhFhCWg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBdcuDIb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45B8111400D6;
	Sat,  2 Nov 2024 06:15:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 02 Nov 2024 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1730542519; x=1730628919; bh=zSrUIPHKklTXI0aHpsL9xGRLorPnobuR
	/CAimIpM94w=; b=cDhFhCWghlSrI+103ww4zg+3ZvI/NCQoJzB92gqtGZ8Dj/cs
	BS15sPtGKQOvfU2nxky5SB6QB27TMerIT0fVis12VMM2DXIrWO/wWy4tRZe5Ql23
	RfOfNzu+xFyb90THnlLny8QCvd1dGPvTMRE0Mx/N0SQT5kVitQXL+TE7K9Ib+AtD
	hPi6BDNNouY2FQ2nG4fj6ToCPVHX+MQl9WUvRHmVorHHiR6bSmA02yM5pvwH8WQM
	7GmdwbLABerfucdm0i4OF4SfElt2jaDAVUmkU36+T/qHIJL+UUxeE4/+kQYTzV8M
	QzT4V2nTu/0nmdOgl2q0PDMfqoTQAqvljUW5oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730542519; x=
	1730628919; bh=zSrUIPHKklTXI0aHpsL9xGRLorPnobuR/CAimIpM94w=; b=X
	BdcuDIbumBOxBgnrWYXm+2aRQE7YwUvuT9X3vMvgAqmkrfqV27LUxfe9cxU0i78W
	gPg2ZYPgDwrrrLiw9hvSgs+5n4/cNeghSntqllZ8bmDKGeayDG9dlpcjy4jkzYg4
	tDKkGxuGqAs4Jqpl2906fjUhN1XtzcLOSKjaiDYQJ1zVxfcu1QhOUTV5Y0pWwi4E
	nBA85bSc0Pns32SVkiEwF+lO2qX05pfBiqb+0S7uuD56JlGv6OvdkK6b0EqBaePl
	cBcQrB1x4M+vb3cHhF9ymZhskEsbwj9+Q7BDwffy7FG8MZlYluW+99btc+pHMs88
	tHSftvD2SAkIMrcpD4tSA==
X-ME-Sender: <xms:tvslZ-HjHVLnxrHkpCCWMAJPzDGPbzugMdbQbckvgGU_2Pm71tX5tQ>
    <xme:tvslZ_VI2EpH3zTMvrTeVfYYSVeoCIi7x6VzwJ7OzBnwF7-vphGszTcKGYjCrTmxh
    O9ABi_rVHIoF6YCYw>
X-ME-Received: <xmr:tvslZ4KG396v1Qbj4UPM7LWZhreWjJwKnr8s2griCfV4pmI6ZSU_GTxUbe3KlOdH4eluAvX1RhGZJF0n-oMKqNAQH0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtsfdttddtvdenucfh
    rhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrf
    grthhtvghrnhepkedtfffffffgueeggeeliefgvdelfffhhedtudetgeefuddtfeehtedu
    heehkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    ephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsth
    essghrohgruggtohhmrdgtohhmpdhrtghpthhtohepsghrhigrnhdqsghtrdhtrghnsegs
    rhhorggutghomhdrtghomhdprhgtphhtthhopehvihhshhhnuhdruggrshgrsegsrhhorg
    gutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tvslZ4F9wLic-fNtGmdPqsb3AMarOJPUotDV5r1OfAWZ57Ooz6SgsQ>
    <xmx:tvslZ0Ua52cTBzxdrxTqtt9S-7t9NQH7lG4qJ0zWMl-JJP3ALZHU6A>
    <xmx:tvslZ7PJgm1PZaceUpGAyRYusDSrtqSBeDojg2HfAB5_W0rx1FaCKw>
    <xmx:tvslZ71EiL8iBcLn4t0v1YQYte5b3---vbo8bbwX8pC-aPZ8nFBsSg>
    <xmx:t_slZyzOhPo5SQUUB1kl421vyTU1IUJhoFKL7NpxPJCx8576WjZ00lyK>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 06:15:18 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id D65E1C5420D3; Sat, 02 Nov 2024 11:15:16 +0100 (CET)
Date: Sat, 2 Nov 2024 11:15:16 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: "open list:VMWARE VMCI DRIVER" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] VMCI: remove unused ioctl definitions
Message-ID: <4nkeqzc57nipww45v7j64vwidqunsnkhj6jm2i6niyp27pbxd3@3oo7qfpur6qo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

IOCTL_VMCI_SOCKETS_VERSION and IOCTL_VMCI_SOCKETS_GET_AF_VALUE were
never implemented, because VSOCK ended up being implemented as a
generic mechanism with a static AF value.  Likewise,
IOCTL_VMCI_SOCKETS_GET_LOCAL_CID ended up being implemented as
IOCTL_VM_SOCKETS_GET_LOCAL_CID.

This isn't a UAPI header, so it should be fine to remove the unused
values.  I've left a comment noting IOCTL_VM_SOCKETS_GET_LOCAL_CID is
in the VMCI range to avoid unintentional reuse.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 include/linux/vmw_vmci_defs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 6fb663b36f72..c2df94696593 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -453,9 +453,7 @@ enum {
 #define IOCTL_VMCI_CTX_GET_CPT_STATE		_IO(7, 0xb1)
 #define IOCTL_VMCI_CTX_SET_CPT_STATE		_IO(7, 0xb2)
 #define IOCTL_VMCI_GET_CONTEXT_ID		_IO(7, 0xb3)
-#define IOCTL_VMCI_SOCKETS_VERSION		_IO(7, 0xb4)
-#define IOCTL_VMCI_SOCKETS_GET_AF_VALUE		_IO(7, 0xb8)
-#define IOCTL_VMCI_SOCKETS_GET_LOCAL_CID	_IO(7, 0xb9)
+/*IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)*/
 #define IOCTL_VMCI_SET_NOTIFY			_IO(7, 0xcb)	/* 1995 */
 /*IOCTL_VMMON_START				_IO(7, 0xd1)*/	/* 2001 */
 

base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
-- 
2.45.1


