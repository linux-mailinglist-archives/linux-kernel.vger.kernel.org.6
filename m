Return-Path: <linux-kernel+bounces-449307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7019F4D07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D421C1676B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AD1F4709;
	Tue, 17 Dec 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="noJgL6Kf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b6yHKgUt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="noJgL6Kf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b6yHKgUt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA61F12FE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444120; cv=none; b=smOoqNsfn+8q4LdaXDr4FpbQPyWhXKuBCQ48Nqx7JLU0rPMcyHbElDFPefEVkVNOVFC6oQ8cDGtK6LM6rNpdytAdjOLVRxtJ0GCN1WXvPyj7zv/HPwflEo7C3nnygDiTKEaibyszysqz9GW4PXOZn7PQw66ftLhT3wV2yzcO5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444120; c=relaxed/simple;
	bh=IjrfHNRisZS/bdSlxi6pvq/uVbTDQZk10S0xnAuPzJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcLKUSQnasow1AEWoj2NqUZq7mJpKeucl/Txa98lQqbnHyh72+PWCNkSK6JMWVvsx7Bn0Za4EkAorYon+/GNaUplT4V3C7ekk1B9RJhBNMnD/L+6lgapF/VWyiV6uUFrcrwNOxcx/ARJdvzlFbunZgQ32xcTlXucVvXSUdmop/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=noJgL6Kf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b6yHKgUt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=noJgL6Kf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b6yHKgUt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A49831F394;
	Tue, 17 Dec 2024 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734444116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=noJgL6Kf9h2aAK9Ebrdi6WcNa5uuZn/eXUpUdJtLmT4RzWgn+f9Ri4wq/L8XICzAz7aYmo
	tOf56ZS9n8pGrCVtes4at04hUtaKkn7Ngu4qGsf5OsARfLHxxkZMAhR2lzsphHckdTN53a
	HJjyfZHJIh5Y3WMcG74u/728s2K98eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734444116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=b6yHKgUtCnuaysrKdVG2FWrua7iFm5a7okFMxXH8tdgGv8laxZpLweSPi5Ka4hcWUAEV4N
	PQlJvVcJKFkdqzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734444116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=noJgL6Kf9h2aAK9Ebrdi6WcNa5uuZn/eXUpUdJtLmT4RzWgn+f9Ri4wq/L8XICzAz7aYmo
	tOf56ZS9n8pGrCVtes4at04hUtaKkn7Ngu4qGsf5OsARfLHxxkZMAhR2lzsphHckdTN53a
	HJjyfZHJIh5Y3WMcG74u/728s2K98eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734444116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=b6yHKgUtCnuaysrKdVG2FWrua7iFm5a7okFMxXH8tdgGv8laxZpLweSPi5Ka4hcWUAEV4N
	PQlJvVcJKFkdqzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B58913A3C;
	Tue, 17 Dec 2024 14:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNzbH1SEYWfgBwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Dec 2024 14:01:56 +0000
Date: Tue, 17 Dec 2024 15:01:55 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Message-ID: <bee71ac4-37bf-4182-ad7e-78efd9baff46@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
 <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Dec 17, 2024 at 10:45:45AM +0100, Hannes Reinecke wrote:
> On 12/17/24 09:35, Daniel Wagner wrote:
> > On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
> > > > +	/*
> > > > +	 * It's either a kernel error or the host observed a connection
> > > > +	 * lost. In either case it's not possible communicate with the
> > > > +	 * controller and thus enter the error code path.
> > > > +	 */
> > > > +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
> > > >    		return status;
> > > >    	/*
> > > > 
> > > Hmm. Maybe checking for NVME_SC_DNR, too?
> > 
> > if no one complains I'll update the check to:
> > 
> > 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> > 	    status == NVME_SC_HOST_PATH_ERROR)
> > 		return status;
> > 
> > okay?
> 
> Which really cries out for a helper. But otherwise okay.

As far I remember, Christoph is not a big fan of single users of tiny
helper functions. Anyway, what about this:

+static bool nvme_num_queue_updated(status)
+{
+       /*
+        * It's either a kernel error or the host observed a connection
+        * lost. In either case it's not possible communicate with the
+        * controller and thus enter the error code path.
+        */
+
+       if (status < 0 || status & NVME_STATUS_DNR ||
+           status == NVME_SC_HOST_PATH_ERROR)
+               return false;
+
+       return true;
+}
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
        u32 q_count = (*count - 1) | ((*count - 1) << 16);
@@ -1701,13 +1716,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)

        status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
                        &result);
-       /*
-        * It's either a kernel error or the host observed a connection
-        * lost. In either case it's not possible communicate with the
-        * controller and thus enter the error code path.
-        */
-       if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
-           status == NVME_SC_HOST_PATH_ERROR)
+
+       if (!nvme_num_queue_updated(status))
                return status;

        /*

