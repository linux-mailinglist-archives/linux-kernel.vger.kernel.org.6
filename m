Return-Path: <linux-kernel+bounces-513127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A166A341CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FB9164E57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82D28135B;
	Thu, 13 Feb 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgxLoCPb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ciMnBOPe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q2aNPY+f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bqFBSvFb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DC281356
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456584; cv=none; b=YjHxMEyHruCfhU8MBaxcB8+ForUFWvkcpgvw1blU3Yy7EJKDKbe6c41LW3aheRd74D7pngLj8/bUYuyqgm+sSX2bOcnIVieDffr3ndRPg5I1gZaDp50vihriSE86hR3JB93oIW5Jna+kqO6kQIwkssjOkzc2ISBX5dueDLV0ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456584; c=relaxed/simple;
	bh=qHRTE181T1PnysTCfj0zjudXcIcINF8uJ5Wje6gwCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2FOmjoxS6JDsoOUYfSezubJyGRHkiyDVzqIKPKrbBApd9pBp5SJZDZhdwk6Zf9dPMEgK63ZoeZPSFOJzqD9rxj3bpPWjjFuF9FZBTfZj97xo3qYNAdK4rqvXD/C09MabCbE9FUVRaU4oFXo9ZUuHywmxZzLGJjq4PKte28yYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgxLoCPb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ciMnBOPe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q2aNPY+f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bqFBSvFb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 194541F86A;
	Thu, 13 Feb 2025 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739456579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJaqS2b6QNx5/ZiATh45FTV2cstJyYJjHzc2Xo5SIsM=;
	b=mgxLoCPbqG61h9bz/Gtrk+2U0O+38aTjh0cKaDgyEZ+tfwUa8tHwJ2ucYsjVYji0uU/Bbj
	NiJ3pJ9rL93flDLRZmW7S/bR+hgpPHJTNnWsVcPnAdysEgu53iSViaKhUbwpuGsMcgdNt8
	r+NxJmBfwJREZqM6okF6cmQRBgDAnYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739456579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJaqS2b6QNx5/ZiATh45FTV2cstJyYJjHzc2Xo5SIsM=;
	b=ciMnBOPebYAEK1O/pSWXwrwCWB/sjqnYO2yOJcnT1kZ3WEOUolvSy9Tvux9O+VHM/8z7cI
	mAjQG/iBHlZdP2BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q2aNPY+f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bqFBSvFb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739456578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJaqS2b6QNx5/ZiATh45FTV2cstJyYJjHzc2Xo5SIsM=;
	b=q2aNPY+f0OIgHVQHJ2GXzNqUeVeyK3szP7NNgX1mjmFsk3J/yhWXAfTrLMuPRa8q/MV0hD
	Urv1PbP4pcbxExQlGKvWkpm2snTKTVUhUB4ZVm2UbTGMXgd2StvO0OFfvfsJL6UrL79PTp
	XlbBorOLRuj+sDiUKTSQqztM7jKzHg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739456578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJaqS2b6QNx5/ZiATh45FTV2cstJyYJjHzc2Xo5SIsM=;
	b=bqFBSvFb0pJJ7e1xXaeu61cS5JDvHDe957AbYk8idG2uzHxCjQa9kNgWlJpElOixMqxNzo
	o3lgfM9Mv8W92FDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B9E137DB;
	Thu, 13 Feb 2025 14:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n9xqAUIArmc3ZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 13 Feb 2025 14:22:58 +0000
Date: Thu, 13 Feb 2025 15:22:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, hch <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Message-ID: <cb11609e-9657-4f41-ba27-567d5fe1b1e3@flourine.local>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
 <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
 <6b6fea1e-671c-4a6a-98ba-a27bb2a4a95a@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6fea1e-671c-4a6a-98ba-a27bb2a4a95a@flourine.local>
X-Rspamd-Queue-Id: 194541F86A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, Feb 13, 2025 at 10:14:46AM +0100, Daniel Wagner wrote:
> That means the idea to synchronize the state change with the
> ASSOC_FAILED bit under the lock is not going to work. I am trying to
> figure out a solution.

I found a possible solution. The only 'catch' is to make the state
machine a bit more restrictive. The only valid transition to LIVE would
be from CONNECTING. We can do this because even the PCI driver is doing
all the state transitions NEW -> CONNECTING -> LIVE. It's important that
we can't enter LIVE from RESETTING to get the patch below working.

We don't have to rely on another variable to figure in which state the
ctrl is. The nvme_fc_ctrl_connectivity_loss callback needs always to
trigger a reset. If the ctrl is not in LIVE it is a no-op. This makes it
possible to remove the lock around the ASSOC_FAILED and the state read
operation.

In nvme_fc_create_association we only have to check if we can enter the
LIVE state (thus we were in CONNECTING) and if this fails we entered the
RESETTING state and should return an error.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab5..f028913e2e62 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f4f1866fbd5b..e740814fd1ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -781,61 +781,12 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 static void
 nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 {
-	enum nvme_ctrl_state state;
-	unsigned long flags;
-
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);

-	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	state = nvme_ctrl_state(&ctrl->ctrl);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
-	switch (state) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-		/*
-		 * Schedule a controller reset. The reset will terminate the
-		 * association and schedule the reconnect timer.  Reconnects
-		 * will be attempted until either the ctlr_loss_tmo
-		 * (max_retries * connect_delay) expires or the remoteport's
-		 * dev_loss_tmo expires.
-		 */
-		if (nvme_reset_ctrl(&ctrl->ctrl)) {
-			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: Couldn't schedule reset.\n",
-				ctrl->cnum);
-			nvme_delete_ctrl(&ctrl->ctrl);
-		}
-		break;
-
-	case NVME_CTRL_CONNECTING:
-		/*
-		 * The association has already been terminated and the
-		 * controller is attempting reconnects.  No need to do anything
-		 * futher.  Reconnects will be attempted until either the
-		 * ctlr_loss_tmo (max_retries * connect_delay) expires or the
-		 * remoteport's dev_loss_tmo expires.
-		 */
-		break;
-
-	case NVME_CTRL_RESETTING:
-		/*
-		 * Controller is already in the process of terminating the
-		 * association.  No need to do anything further. The reconnect
-		 * step will kick in naturally after the association is
-		 * terminated.
-		 */
-		break;
-
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	default:
-		/* no action to take - let it delete */
-		break;
-	}
+	nvme_reset_ctrl(&ctrl->ctrl);
 }

 /**
@@ -3177,23 +3128,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
+	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
+		ret = -EIO;
 	if (ret)
 		goto out_term_aen_ops;

-	spin_lock_irqsave(&ctrl->lock, flags);
-	if (!test_bit(ASSOC_FAILED, &ctrl->flags))
-		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	else
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE)) {
 		ret = -EIO;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
-	if (ret)
 		goto out_term_aen_ops;
+	}

 	ctrl->ctrl.nr_reconnects = 0;
-
-	if (changed)
-		nvme_start_ctrl(&ctrl->ctrl);
+	nvme_start_ctrl(&ctrl->ctrl);

 	return 0;	/* Success */

