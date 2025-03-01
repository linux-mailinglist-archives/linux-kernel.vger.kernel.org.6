Return-Path: <linux-kernel+bounces-539882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D75A4AA43
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096FB16CC8B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7D1D88D7;
	Sat,  1 Mar 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xcN26atI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Qo97uPJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xcN26atI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Qo97uPJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65C1BE251
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825793; cv=none; b=VWhnTpK9CtBStfJu30uNvKMedUuMSrw5ALZrvfS4P/EVtkn4VuhVc5ARx32It51UOAJhRqcSABDWqjTLYT0BJ39aXkz4lcxB7Lv+eauDgff1KTu4o+wv+Kg1u9+DAI2zd/EtvYT4iijp4dcndpQxe/KCkKMbzdcAyAdSytnNUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825793; c=relaxed/simple;
	bh=7ZaYonJCSLWP/DYOS2vetXe5WtqDn1Wvmjawh21tRQQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYKBAVpGSdKgBuuUqiqgJr9rViIZczqZhFj2SWxWzsS8m59ADkFUfNuaB2/Hm7jNt26NvhsOyVl3FwHxmaV8AZvzUKCIyeRQYtCzfTVG7sYrXdbHZQEXgsWdeynOsb44i7NimEmYqMKsfVfgCezqO7InU+RtuSFO0seBb4/G85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xcN26atI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Qo97uPJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xcN26atI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Qo97uPJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D24F21179;
	Sat,  1 Mar 2025 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740825783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Poud6LuAB30cVGItEfJ9VufWc1hBKXQ3R/b5A1Zec=;
	b=xcN26atIufgYunL4Km5EFZ+lfO2Mwl79cX/7r0uCsjfPF+88EF99jDEGK/dI+siLp8+SWS
	VL1VvqvrFiJcyUH7l+epBSa6Lej2ORlnfa6YrY3ZHpb+Oz6orYZxAO+xEV0QtvBM8O/TNR
	zaBXmWAvgWhl30aqmpDiCjWXMy94YzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740825783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Poud6LuAB30cVGItEfJ9VufWc1hBKXQ3R/b5A1Zec=;
	b=7Qo97uPJ9Vuj0xX52L+hEI9L6AKh0nnmMX3O4wcD6C5Pxx1dx6pq6nPU1Oekwpm2UNm/dt
	S8kFa0TI7pihXBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740825783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Poud6LuAB30cVGItEfJ9VufWc1hBKXQ3R/b5A1Zec=;
	b=xcN26atIufgYunL4Km5EFZ+lfO2Mwl79cX/7r0uCsjfPF+88EF99jDEGK/dI+siLp8+SWS
	VL1VvqvrFiJcyUH7l+epBSa6Lej2ORlnfa6YrY3ZHpb+Oz6orYZxAO+xEV0QtvBM8O/TNR
	zaBXmWAvgWhl30aqmpDiCjWXMy94YzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740825783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1Poud6LuAB30cVGItEfJ9VufWc1hBKXQ3R/b5A1Zec=;
	b=7Qo97uPJ9Vuj0xX52L+hEI9L6AKh0nnmMX3O4wcD6C5Pxx1dx6pq6nPU1Oekwpm2UNm/dt
	S8kFa0TI7pihXBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3B6A13419;
	Sat,  1 Mar 2025 10:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lC7WLbbkwmcWLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 01 Mar 2025 10:43:02 +0000
Date: Sat, 01 Mar 2025 11:43:02 +0100
Message-ID: <87r03h9gll.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<perex@perex.cz>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid context in snd_card_locked
In-Reply-To: <87tt8d9hj7.wl-tiwai@suse.de>
References: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
	<87y0xp9jr8.wl-tiwai@suse.de>
	<c57573e5-8208-495f-ba53-4d9962c0e9b6@quicinc.com>
	<87tt8d9hj7.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[4cb9fad083898f54c517];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -0.80
X-Spam-Flag: NO

On Sat, 01 Mar 2025 11:22:52 +0100,
Takashi Iwai wrote:
> 
> On Sat, 01 Mar 2025 10:50:43 +0100,
> Zhongqiu Han wrote:
> > 
> > On 3/1/2025 5:34 PM, Takashi Iwai wrote:
> > > On Sat, 01 Mar 2025 10:25:55 +0100,
> > > Zhongqiu Han wrote:
> > >> 
> > >>> Hello,
> > >>> 
> > >>> syzbot found the following issue on:
> > >>> 
> > >>> HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
> > >>> git tree:       upstream
> > >>> console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
> > >>> kernel config:
> > >> https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
> > >>> dashboard link:
> > >> https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
> > >>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > >> for Debian) 2.40
> > >> 
> > >> 
> > >> BUG: sleeping function called from invalid context and
> > >> raw_local_irq_restore() called with IRQs enabled seems can be
> > >> fixed by below change. if it is valid, will arise the PATCH.
> > > 
> > > snd_timer_process_callbacks() gets called from two places, one from
> > > snd_timer_work() and another from snd_timer_interrupt() where both
> > > caller cover already with guard(spinlock_irqsave).  That is, it's a
> > > nested lock, hence without _irqsave().
> > > 
> > > IMO, the question is rather why the check of "!in_interrupt()" in
> > > snd_seq_client_use_ptr() passed in this call path.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > 
> > Thanks Takashi for the discussion.
> > 
> > I have an initial check:
> > func snd_seq_check_queue is called from func snd_seq_timer_interrupt,
> > and the scoped_guard can not cover it. maybe this the reason of
> > !in_interrupt() check pass.
> > 
> > just like my patch shared, snd_timer_process_callbacks called
> > spin_unlock but not spin_unlock_irqrestore, which caused
> > irqs_disabled(): 1 , and then caused the BUG.
> > 
> > 
> > BUG: sleeping function called from invalid context at
> > kernel/locking/mutex.c:562
> > in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1167, name:
> > kworker/0:1H
> > 
> > 
> > please feel free and kindly correct me if any misunderstanding.
> 
> Ah, no, the code in timer.c worked as expected; the lock in the caller
> side is temporarily released intentionally for avoiding deadlock.
> 
> It's rather the problem in seq_clientmgr.c side, as I mentioned.  The
> check with !in_interrupt() is fragile in this case, and it's an
> overkill to handle the module loading whenever it's referenced.
> 
> I'm going to submit the fix patch later.

Below is the copy:


Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Avoid module auto-load handling at event delivery

snd_seq_client_use_ptr() is supposed to return the snd_seq_client
object for the given client ID, and it tries to handle the module
auto-loading when no matching object is found.  Although the module
handling is performed only conditionally with "!in_interrupt()", this
condition may be fragile, e.g. when the code is called from the ALSA
timer callback where the spinlock is temporarily disabled while the
irq is disabled.  Then his doesn't fit well and spews the error about
sleep from invalid context, as complained recently by syzbot.

Also, in general, handling the module-loading at each time if no
matching object is found is really an overkill.  It can be still
useful when performed at the top-level ioctl or proc reads, but it
shouldn't be done at event delivery at all.

For addressing the issues above, this patch disables the module
handling in snd_seq_client_use_ptr() in normal cases like event
deliveries, but allow only in limited and safe situations.
A new function client_load_and_use_ptr() is used for the cases where
the module loading can be done safely, instead.

Reported-by: syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67c272e5.050a0220.dc10f.0159.GAE@google.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 46 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index cb66ec42a3f8..706f53e39b53 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -106,7 +106,7 @@ static struct snd_seq_client *clientptr(int clientid)
 	return clienttab[clientid];
 }
 
-struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+static struct snd_seq_client *client_use_ptr(int clientid, bool load_module)
 {
 	unsigned long flags;
 	struct snd_seq_client *client;
@@ -126,7 +126,7 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	}
 	spin_unlock_irqrestore(&clients_lock, flags);
 #ifdef CONFIG_MODULES
-	if (!in_interrupt()) {
+	if (load_module) {
 		static DECLARE_BITMAP(client_requested, SNDRV_SEQ_GLOBAL_CLIENTS);
 		static DECLARE_BITMAP(card_requested, SNDRV_CARDS);
 
@@ -168,6 +168,20 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	return client;
 }
 
+/* get snd_seq_client object for the given id quickly */
+struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, false);
+}
+
+/* get snd_seq_client object for the given id;
+ * if not found, retry after loading the modules
+ */
+static struct snd_seq_client *client_load_and_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, IS_ENABLED(CONFIG_MODULES));
+}
+
 /* Take refcount and perform ioctl_mutex lock on the given client;
  * used only for OSS sequencer
  * Unlock via snd_seq_client_ioctl_unlock() below
@@ -176,7 +190,7 @@ bool snd_seq_client_ioctl_lock(int clientid)
 {
 	struct snd_seq_client *client;
 
-	client = snd_seq_client_use_ptr(clientid);
+	client = client_load_and_use_ptr(clientid);
 	if (!client)
 		return false;
 	mutex_lock(&client->ioctl_mutex);
@@ -1195,7 +1209,7 @@ static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void  *arg)
 	int err = 0;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1257,7 +1271,7 @@ static int snd_seq_ioctl_get_client_info(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(client_info->client);
+	cptr = client_load_and_use_ptr(client_info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1396,7 +1410,7 @@ static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client, void *arg)
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -1503,10 +1517,10 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
 
-	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	receiver = client_load_and_use_ptr(subs->dest.client);
 	if (!receiver)
 		goto __end;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -1871,7 +1885,7 @@ static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
 	struct snd_seq_client_pool *info = arg;
 	struct snd_seq_client *cptr;
 
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;
 	memset(info, 0, sizeof(*info));
@@ -1975,7 +1989,7 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	struct snd_seq_client_port *sport = NULL;
 
 	result = -EINVAL;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -2006,7 +2020,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 	struct list_head *p;
 	int i;
 
-	cptr = snd_seq_client_use_ptr(subs->root.client);
+	cptr = client_load_and_use_ptr(subs->root.client);
 	if (!cptr)
 		goto __end;
 	port = snd_seq_port_use_ptr(cptr, subs->root.port);
@@ -2073,7 +2087,7 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
 	if (info->client < 0)
 		info->client = 0;
 	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
-		cptr = snd_seq_client_use_ptr(info->client);
+		cptr = client_load_and_use_ptr(info->client);
 		if (cptr)
 			break; /* found */
 	}
@@ -2096,7 +2110,7 @@ static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port = NULL;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -2193,7 +2207,7 @@ static int snd_seq_ioctl_client_ump_info(struct snd_seq_client *caller,
 		size = sizeof(struct snd_ump_endpoint_info);
 	else
 		size = sizeof(struct snd_ump_block_info);
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (!cptr)
 		return -ENOENT;
 
@@ -2475,7 +2489,7 @@ int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
 	if (check_event_type_and_length(ev))
 		return -EINVAL;
 
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (cptr == NULL)
 		return -EINVAL;
 	
@@ -2707,7 +2721,7 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 
 	/* list the client table */
 	for (c = 0; c < SNDRV_SEQ_MAX_CLIENTS; c++) {
-		client = snd_seq_client_use_ptr(c);
+		client = client_load_and_use_ptr(c);
 		if (client == NULL)
 			continue;
 		if (client->type == NO_CLIENT) {

