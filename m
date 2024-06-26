Return-Path: <linux-kernel+bounces-230756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC1918186
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A24E1C20E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D22181CEF;
	Wed, 26 Jun 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ipwPamAf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ipwPamAf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444891E87C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406708; cv=none; b=FFRUInU/s77bFsJ7wtsknnnv9+ElfLJQpZExuSJXD8r1+fmIITHrYDvBEUlL8aC3JxJiOVru5B1O6jSLDKUJQGVqaeprlTbN5cZeq5DufBSwRG6pkDae818tdgkhfTeZNS+Jj2/m4HRdxA/D0IH1Ds9uqdlVbd0o8QOlNbn4TVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406708; c=relaxed/simple;
	bh=T3QhLC9IiewNqorC95c9RDDHKQweFI8PAk5Hc/uNn3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o61Vh7bpla44KDfPBwSTaqSf7L9braThvJXVepQldl//cHN5vmZMxVLNgqZOZeZjKK/nfFlHnWF5zoADtk9d7TCbHA67fqPTZ+w9+CRRSoZB+blmsLGFiuRK+pM5DC5B+J6QtxUwGl2LO1B+tmVygorHyhnpIzmQnXdFsxyMNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ipwPamAf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ipwPamAf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600BC1FB57;
	Wed, 26 Jun 2024 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719406704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AayzxyR98gxxfib377YcZklJeO8xn1MdMPn8nmG9fnc=;
	b=ipwPamAfglRibdvncE8LR1Kr/5pbbeqX7OwFYiBWUVI7Gr4iYcwIwqDPb/TyuaCZ5BFyc7
	QYciU7zz13LOK3WCM9BAHPWQM8gEcu2kJInC+w+1/N90g2PFe37JXinxuMzEIyarbc1DQE
	NzGJgDpvLBcfvubjTRSB5NbQ7sbji+4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719406704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AayzxyR98gxxfib377YcZklJeO8xn1MdMPn8nmG9fnc=;
	b=ipwPamAfglRibdvncE8LR1Kr/5pbbeqX7OwFYiBWUVI7Gr4iYcwIwqDPb/TyuaCZ5BFyc7
	QYciU7zz13LOK3WCM9BAHPWQM8gEcu2kJInC+w+1/N90g2PFe37JXinxuMzEIyarbc1DQE
	NzGJgDpvLBcfvubjTRSB5NbQ7sbji+4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AA24139C2;
	Wed, 26 Jun 2024 12:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QbwKEnAQfGYhNgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 26 Jun 2024 12:58:24 +0000
Date: Wed, 26 Jun 2024 14:58:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix scalability problem in workqueue watchdog touch
 caused by stop_machine
Message-ID: <zrldvk6ampjlkcpgh36vq477oeifss3zzgqutcawm2chdveh4e@mkrv2atdiaho>
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slwzo4l6yme3xvoh"
Content-Disposition: inline
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,linux.vnet.ibm.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spam-Level: 


--slwzo4l6yme3xvoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Nicholas.

On Tue, Jun 25, 2024 at 09:42:43PM GMT, Nicholas Piggin <npiggin@gmail.com> wrote:
> Here are a few patches to fix a lockup caused by very slow progress due
> to a scalability problem in workqueue watchdog touch being hammered by
> thousands of CPUs in multi_cpu_stop. Patch 2 is the fix.

<del>Is this something you noticed with stop_machine alone or in some broader
context?</del> I see you mention CPU hotplug in patch 2. Was it a single
CPU or SMT offlining?
Good job tracking it down touching same cacheline.
I had a suspicion [1] back in the day that cpuhp_smt_disable() would
scale in O(nr_cpus^2) but I didn't dedicate time to verifying that. Has
something similar popped up in your examination?

Also, I think your change in patch 2 effectively reduces
wq_watchdog_thresh to 3/4 of configured value. (Not sure if default
should be scaled accordingly.)

Thanks,
Michal

[1]
cpuhp_smt_disable
  mutex_lock(&cpu_add_remove_lock); // cpu_maps_update_begin()

  for_each_online_cpu                      // <-- nr_cpus
    takedown_cpu(cpu)
      stop_machine_cpuslocked // cpu_hotplug_lock
        active_cpus = cpumask_of(cpu)
        for_each_cpu(cpu, cpu_online_mask) // <-- nr_cpus
          cpu_stop_queue_work(cpu, work) // this is serial
          multi_cpu_stop // this runs nr_cpus in parallel
            // runs on downed cpu only
            take_cpu_down
            // other cpus are spinning in multi_cpu_stop() until take_cpu_down
            // above is finished on downed cpu
            // with interrupts disabled
            do {cpu_relax} while(curstate != MULTI_STOP_EXIT)
    lockup_detector_cleanup() // not a touch

  mutex_unlock(&cpu_add_remove_lock);



--slwzo4l6yme3xvoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZnwQbAAKCRAt3Wney77B
Sf00AQDjTZSV+ys7BkIRaL0xWi4guPuuPqOgP2OZ9hbgXROsrwEAqFa/uHdZJdvV
1iB2QDB2an4mY7vhRnEgZyj4ehj2Ew4=
=FBpE
-----END PGP SIGNATURE-----

--slwzo4l6yme3xvoh--

