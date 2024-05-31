Return-Path: <linux-kernel+bounces-197092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D635C8D660E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A191C243A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47958155CA1;
	Fri, 31 May 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jIybjC9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0SLkSQk"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FC5381A;
	Fri, 31 May 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170524; cv=none; b=pWTNqHiz6t1LeEvvrZvyJEckpoT3Q53YKKAkB15f//oX0rJQJw5xR6lbk+zBybEhXd86C6IqimxRQPUqM2MXDCtJ7HrrAKhm1zBmCAOVbGOyqBN5B/ikCFtMFhU21HqdkV748Pm3s7/7Sj02zIKlwd/QYaotNj/SnYjQ1ISkswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170524; c=relaxed/simple;
	bh=61E/ErJu45D7guQqzsP7BQNsV5UyMSJHMfRnwmHWxjc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BJqY7dCB9oWMQ8EQVSiqQbv4CjJ5RQI6AAwwwKoKx0iGdR/LbXIC7KoZWLBSUPoW3K93eQmZlimur69JSQ8pbdQh+Voia4AWBcQWFDOtInm1QUv2pD2mbrMWg0HpL0n7nDU/gmAS6pMdxXIXAfvKUX0tHWDd+zT/zag4FykE2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jIybjC9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0SLkSQk; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 93A191C00160;
	Fri, 31 May 2024 11:48:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 31 May 2024 11:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717170519; x=1717256919; bh=Vk7TxYLjrj
	s/FudE0csVgGGBVMmJn35CzhDM4RfXbwQ=; b=jIybjC9TsCkJf3k/NTiN6wkRlc
	uPkU6SgFPhzLYzMjrRxa9WrTXRSdjaI39n21EGJcKHeMTOzho/9Pxdw+NHC2RZhu
	WLIbpEIyNbaLdX8q9a5H9N/dCACf91th088xlp6hx5aiAdd2AzukOoKUuGKV/MKr
	EgIeSZyrfiIgW1RfiBu3lhSUgAKZWeWO1RiDvT9wMfiQEYQ3A6uDoRfCfDi0M0Cm
	MMQvmZiG70x8R7IDjHmYQKiL/pZgkeUubB7Tm5bvBsqWD1dIi32h5xNXSCS2sjbf
	qIXEXMgxslm5r0JG6d7NjEj0rK85pR3lC6L0tA1Ygu6/F/apilpZbgTJEa7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717170519; x=1717256919; bh=Vk7TxYLjrjs/FudE0csVgGGBVMmJ
	n35CzhDM4RfXbwQ=; b=E0SLkSQkc7q1BCqWWztAuNwJWJc7AjfaSJgnk/hdENkX
	EivNG7vEvbgkBoexJia3yG4c6aACNaqd2j1T7AFetY4pij5qXBF0Y1qnQmlBYpoX
	hgSr0R9b18RMRTUyEZJbD78yN5cDo+HoLKhxyOZVSvXmsPeiYn+vZTWccWEFIEKF
	6nxR16A8F9bw9iUU8YUzEFhr2StrMalJPkoZFzixOeGtl5R9E3FimbKRLV53wAf4
	zc//cADYZQ9kxfie1sLMlsz+3EOSFGcTpU39/7iqIv8uWCMaFJyWSmC/fFi8PJKJ
	L/Kqam15GEcKEUXEL3VxtV80Gy0bHWUpq/rCQYcP2w==
X-ME-Sender: <xms:VfFZZgPxthremOBzans2GKJ5j6yyglrlGDC4rqPHP98ecZ1CULGp_g>
    <xme:VfFZZm9sJ80da5DscUNTffPoTDDuNhdia-Dl4OofwYhEWvAVPuVn3jMQfA6-mFfOQ
    3yWBjsIeB8r0NasOUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepteffffeigeejuedvhfejkeehjeeiieekteetjeduieehudegfeevieejhfej
    ueeinecuffhomhgrihhnpehmrghtthhsthekkedrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VfFZZnQ96fTjjglaUQwCH_EMufIb2r5I2pGI12UM9wloUjJxXbX4GA>
    <xmx:VfFZZovOWFiJc08to74-BuPS2oBTBqxgvAHwcmYOKvTLrurUoNKGUA>
    <xmx:VfFZZoeXyJXhz2v1fYdG3eh35_2GRQ4Cub_KqsCLb7OqNBs74r6c8A>
    <xmx:VfFZZs1q5kF2Z_ayU4SguM1Xb4eReljOficeQqbyAvf0B_ZWqIz_rA>
    <xmx:V_FZZn8QgD-rVt-Oeyu2eMjR361K4jkjzrmOEvoo8IZWlRBwsq4T7MRi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BA253B6008D; Fri, 31 May 2024 11:48:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
Date: Fri, 31 May 2024 17:48:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Marc Zyngier" <maz@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "Michael Cree" <mcree@orcon.net.nz>,
 "Frank Scheiner" <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Content-Type: text/plain

On Wed, May 29, 2024, at 20:50, Maciej W. Rozycki wrote:
> On Tue, 28 May 2024, Paul E. McKenney wrote:

>  What I have been after actually is: can you point me at a piece of code 
> in our tree that will cause an issue with a non-BWX Alpha as described in 
> your scenario, so that I have a starting point?  Mind that I'm completely 
> new to RCU as I didn't have a need to research it before (though from a 
> skim over Documentation/RCU/rcu.rst I understand what its objective is).

I tried to look for examples and started with users of WRITE_ONCE()
on small variables by only allowing it to be used on types that
can be written natively:

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -451,8 +451,7 @@ struct ftrace_likely_data {
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
-       (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-        sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+       (sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)          \

The WRITE_ONCE() calls tend to be there in order to avoid
expensive atomic or locking when something can be expressed
with a store that known to be visible atomically (on all other
architectures).

I then tried changing the underlying variables to 32-bit ones
to see how many changes are needed, but I gave up after around
150 of them, as I was only scratching the surface. To do this
right, you'd need to go through each one of them and come up
with a solution that is the best trade-off in terms of memory
usage and performance for that one. There are of course
others that should be using WRITE_ONCE() and are missing
this, so the list is not complete either. See below for
the ones I could find quickly.

>  FWIW even if it was only me I think that depriving the already thin Alpha 
> port developer base of any quantity of the remaining manpower, by dropping 
> support for a subset of the hardware available, and then a subset that is 
> not just as exotic as the original i386 became to the x86 platform at the 
> time support for it was dropped, is only going to lead to further demise 
> and eventual drop of the entire port.

I know you like you museum pieces to be older than everyone
else's, and I'm sorry that my patch series is causing you
problems, but I don't think the more general criticism is
valid here. My hope was mainly to help our with both keeping
Alpha viable for a few more years while also allowing Paul
to continue with his RCU changes.

As far as I can tell, nobody else is actually using EV4
machines or has been for years now, but the presence of that
code did affect both the performance and correctness of the
kernel code for all EV56+ users since distros have no way
of picking the ISA level on alpha for a generic kernel.

As I wrote in my patch notes, Debian already changed their
userspace to be built for EV56 or higher, as they had
determined that this was a significant improvement for
their users, so there is no binary distro left to ship
with a modern kernel.

Matt still maintains the Gentoo port (in addition to alpha
kernel), which seems to still support EV4, but all eight
of his machines on https://mattst88.com/computers/ are
EV56 or higher.

The strongest argument I see for assuming non-BWX alphas
are long dead is that gcc-4.4 added support for C11 style
_Atomic variables for alpha, but got the stores wrong
without anyone ever noticing the problem. Even one makes
the argument that normal byte stores and volatiles ones
should not need atomic ll/st sequenes, the atomics
clearly do. Building BWX-enabled kernels and userland
completely avoids this problem, which make debugging
easier for the remaining users when stuff breaks.

   Arnd

----
below: partial patch to change types for WRITE_ONCE() variables,

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5d1779759c21..11f1368808fe 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -451,8 +451,7 @@ struct ftrace_likely_data {
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
-	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+	(sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index b1e7415f8439..86402997df21 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -71,7 +71,7 @@ static mempool_t *bio_fallback_crypt_ctx_pool;
  * be used at a time - the rest of the unused tfms have their keys cleared.
  */
 static DEFINE_MUTEX(tfms_init_lock);
-static bool tfms_inited[BLK_ENCRYPTION_MODE_MAX];
+static int tfms_inited[BLK_ENCRYPTION_MODE_MAX];
 
 static struct blk_crypto_fallback_keyslot {
 	enum blk_crypto_mode_num crypto_mode;diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index ad66a3081735..4e675dc1ea29 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -41,10 +41,10 @@ struct hrtimer {
 	ktime_t				_softexpires;
 	enum hrtimer_restart		(*function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
-	u8				state;
-	u8				is_rel;
-	u8				is_soft;
-	u8				is_hard;
+	u32				state;
+	u32				is_rel;
+	u32				is_soft;
+	u32				is_hard;
 };
 
 #endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 91224bbcfa73..11d2b5da3982 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -411,8 +411,8 @@ struct io_ring_ctx {
 
 	/* napi busy poll default timeout */
 	unsigned int		napi_busy_poll_to;
-	bool			napi_prefer_busy_poll;
-	bool			napi_enabled;
+	int			napi_prefer_busy_poll;
+	int			napi_enabled;
 
 	DECLARE_HASHTABLE(napi_ht, 4);
 #endif
@@ -605,7 +605,7 @@ struct io_kiocb {
 
 	u8				opcode;
 	/* polled IO has completed */
-	u8				iopoll_completed;
+	u32				iopoll_completed;
 	/*
 	 * Can be either a fixed buffer index, or used with provided buffers.
 	 * For the latter, before issue it points to the buffer group ID,
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 383a0ea2ab91..0f72f411b520 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -254,7 +254,7 @@ struct ipv6_pinfo {
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
-	__u8			pmtudisc;
+	__u32			pmtudisc;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/linux/key.h b/include/linux/key.h
index 943a432da3ae..8809e797417e 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -218,7 +218,7 @@ struct key {
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
 						 */
-	short			state;		/* Key state (+) or rejection error (-) */
+	int			state;		/* Key state (+) or rejection error (-) */
 
 #ifdef KEY_DEBUGGING
 	unsigned		magic;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 546de9cf46df..a7ef1e3aa9d0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2047,7 +2047,7 @@ struct net_device {
 	 * and to use WRITE_ONCE() to annotate the writes.
 	 */
 	unsigned int		mtu;
-	unsigned short		needed_headroom;
+	unsigned int		needed_headroom;
 	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
 #ifdef CONFIG_XPS
 	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
@@ -2298,7 +2298,7 @@ struct net_device {
 
 	struct list_head	link_watch_list;
 
-	u8 reg_state;
+	u32 reg_state;
 
 	bool dismantle;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..5eadcdfcf089 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -719,10 +719,10 @@ struct uclamp_se {
 
 union rcu_special {
 	struct {
-		u8			blocked;
-		u8			need_qs;
-		u8			exp_hint; /* Hint for performance. */
-		u8			need_mb; /* Readers need smp_mb(). */
+		u32			blocked;
+		u32			need_qs;
+		u32			exp_hint; /* Hint for performance. */
+		u32			need_mb; /* Readers need smp_mb(). */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..8dafb3e49546 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -125,7 +125,7 @@ struct tcp_options_received {
 	u8	saw_unknown:1,	/* Received unknown option		*/
 		unused:7;
 	u8	num_sacks;	/* Number of SACK blocks		*/
-	u16	user_mss;	/* mss requested by user in ioctl	*/
+	u32	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
 };
 
@@ -237,8 +237,8 @@ struct tcp_sock {
 	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
 	u32	rttvar_us;	/* smoothed mdev_max			*/
 	u32	retrans_out;	/* Retransmitted packets out		*/
-	u16	advmss;		/* Advertised MSS			*/
-	u16	urg_data;	/* Saved octet of OOB data and control flags */
+	u32	advmss;		/* Advertised MSS			*/
+	u32	urg_data;	/* Saved octet of OOB data and control flags */
 	u32	lost;		/* Total data packets lost incl. rexmits */
 	struct  minmax rtt_min;
 	/* OOO segments go in this rbtree. Socket lock must be held. */
@@ -383,7 +383,7 @@ struct tcp_sock {
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
 		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
 
-	u8	keepalive_probes; /* num of allowed keep alive probes	*/
+	u32	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3eb3f2b9a2a0..2bba12ee545e 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -54,19 +54,19 @@ struct udp_sock {
 	unsigned long	 udp_flags;
 
 	int		 pending;	/* Any pending frames ? */
-	__u8		 encap_type;	/* Is this an Encapsulation socket? */
+	__u32		 encap_type;	/* Is this an Encapsulation socket? */
 
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
 	 */
 	__u16		 len;		/* total length of pending frames */
-	__u16		 gso_size;
+	__u32		 gso_size;
 	/*
 	 * Fields specific to UDP-Lite.
 	 */
-	__u16		 pcslen;
-	__u16		 pcrlen;
+	__u32		 pcslen;
+	__u32		 pcrlen;
 	/*
 	 * For encapsulation sockets.
 	 */
@@ -94,7 +94,7 @@ struct udp_sock {
 	int		forward_threshold;
 
 	/* Cache friendly copy of sk->sk_peek_off >= 0 */
-	bool		peeking_with_offset;
+	int		peeking_with_offset;
 };
 
 #define udp_test_bit(nr, sk)			\
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 7d6b1254c92d..b549a39360ec 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -105,11 +105,11 @@ struct inet_connection_sock {
 	__u8			  icsk_retransmits;
 	__u8			  icsk_pending;
 	__u8			  icsk_backoff;
-	__u8			  icsk_syn_retries;
+	__u32			  icsk_syn_retries;
 	__u8			  icsk_probes_out;
 	__u16			  icsk_ext_hdr_len;
 	struct {
-		__u8		  pending;	 /* ACK is pending			   */
+		__u32		  pending;	 /* ACK is pending			   */
 		__u8		  quick;	 /* Scheduled number of quick acks	   */
 		__u8		  pingpong;	 /* The session is interactive		   */
 		__u8		  retry;	 /* Number of attempts			   */
@@ -120,7 +120,7 @@ struct inet_connection_sock {
 		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
-		__u16		  rcv_mss;	 /* MSS used for delayed ACK decisions	   */
+		__u32		  rcv_mss;	 /* MSS used for delayed ACK decisions	   */
 	} icsk_ack;
 	struct {
 		/* Range of MTUs to search */
diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 5af6eb14c5db..5d368156e437 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -18,7 +18,7 @@ struct fqdir {
 	int			max_dist;
 	struct inet_frags	*f;
 	struct net		*net;
-	bool			dead;
+	int			dead;
 
 	struct rhashtable       rhashtable ____cacheline_aligned_in_smp;
 
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index f9ddd47dc4f8..98f2c745a34e 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -220,17 +220,17 @@ struct inet_sock {
 
 	unsigned long		inet_flags;
 	__be32			inet_saddr;
-	__s16			uc_ttl;
+	__s32			uc_ttl;
 	__be16			inet_sport;
 	struct ip_options_rcu __rcu	*inet_opt;
 	atomic_t		inet_id;
 
-	__u8			tos;
-	__u8			min_ttl;
-	__u8			mc_ttl;
-	__u8			pmtudisc;
-	__u8			rcv_tos;
-	__u8			convert_csum;
+	__u32			tos;
+	__u32			min_ttl;
+	__u32			mc_ttl;
+	__u32			pmtudisc;
+	__u32			rcv_tos;
+	__u32			convert_csum;
 	int			uc_index;
 	int			mc_index;
 	__be32			mc_addr;
diff --git a/include/net/ip.h b/include/net/ip.h
index 6d735e00d3f3..e0cb7e0bfec9 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -81,7 +81,7 @@ struct ipcm_cookie {
 	__u8			ttl;
 	__s16			tos;
 	char			priority;
-	__u16			gso_size;
+	__u32			gso_size;
 };
 
 static inline void ipcm_init(struct ipcm_cookie *ipcm)
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 9b2f69ba5e49..182b7eade5c0 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -139,7 +139,7 @@ struct fib_info {
 	refcount_t		fib_treeref;
 	refcount_t		fib_clntref;
 	unsigned int		fib_flags;
-	unsigned char		fib_dead;
+	u32			fib_dead;
 	unsigned char		fib_protocol;
 	unsigned char		fib_scope;
 	unsigned char		fib_type;
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 88a8e554f7a1..4732c3084e10 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -358,7 +358,7 @@ struct ipcm6_cookie {
 	struct sockcm_cookie sockc;
 	__s16 hlimit;
 	__s16 tclass;
-	__u16 gso_size;
+	__u32 gso_size;
 	__s8  dontfrag;
 	struct ipv6_txoptions *opt;
 };
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0d28172193fa..e2f580880977 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -147,10 +147,10 @@ struct neighbour {
 	struct timer_list	timer;
 	unsigned long		used;
 	atomic_t		probes;
-	u8			nud_state;
-	u8			type;
-	u8			dead;
-	u8			protocol;
+	u32			nud_state;
+	u32			type;
+	u32			dead;
+	u32			protocol;
 	u32			flags;
 	seqlock_t		ha_lock;
 	unsigned char		ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))] __aligned(8);
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 78214f1b43a2..46d9b3966c5b 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -14,7 +14,7 @@ struct netns_core {
 
 	int	sysctl_somaxconn;
 	int	sysctl_optmem_max;
-	u8	sysctl_txrehash;
+	u32	sysctl_txrehash;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index c356c458b340..3df67aa03c3c 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -48,27 +48,27 @@ struct netns_ipv4 {
 
 	/* TX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_tx);
-	u8 sysctl_tcp_early_retrans;
-	u8 sysctl_tcp_tso_win_divisor;
-	u8 sysctl_tcp_tso_rtt_log;
-	u8 sysctl_tcp_autocorking;
+	u32 sysctl_tcp_early_retrans;
+	u32 sysctl_tcp_tso_win_divisor;
+	u32 sysctl_tcp_tso_rtt_log;
+	u32 sysctl_tcp_autocorking;
 	int sysctl_tcp_min_snd_mss;
 	unsigned int sysctl_tcp_notsent_lowat;
 	int sysctl_tcp_limit_output_bytes;
 	int sysctl_tcp_min_rtt_wlen;
 	int sysctl_tcp_wmem[3];
-	u8 sysctl_ip_fwd_use_pmtu;
+	u32 sysctl_ip_fwd_use_pmtu;
 	__cacheline_group_end(netns_ipv4_read_tx);
 
 	/* TXRX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_txrx);
-	u8 sysctl_tcp_moderate_rcvbuf;
+	u32 sysctl_tcp_moderate_rcvbuf;
 	__cacheline_group_end(netns_ipv4_read_txrx);
 
 	/* RX readonly hotpath cache line */
 	__cacheline_group_begin(netns_ipv4_read_rx);
-	u8 sysctl_ip_early_demux;
-	u8 sysctl_tcp_early_demux;
+	u32 sysctl_ip_early_demux;
+	u32 sysctl_tcp_early_demux;
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_rmem[3];
 	__cacheline_group_end(netns_ipv4_read_rx);
@@ -96,7 +96,7 @@ struct netns_ipv4 {
 #endif
 	bool			fib_has_custom_local_routes;
 	bool			fib_offload_disabled;
-	u8			sysctl_tcp_shrink_window;
+	u32			sysctl_tcp_shrink_window;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	atomic_t		fib_num_tclassid_users;
 #endif
@@ -108,11 +108,11 @@ struct netns_ipv4 {
 	struct inet_peer_base	*peers;
 	struct fqdir		*fqdir;
 
-	u8 sysctl_icmp_echo_ignore_all;
-	u8 sysctl_icmp_echo_enable_probe;
-	u8 sysctl_icmp_echo_ignore_broadcasts;
-	u8 sysctl_icmp_ignore_bogus_error_responses;
-	u8 sysctl_icmp_errors_use_inbound_ifaddr;
+	u32 sysctl_icmp_echo_ignore_all;
+	u32 sysctl_icmp_echo_enable_probe;
+	u32 sysctl_icmp_echo_ignore_broadcasts;
+	u32 sysctl_icmp_ignore_bogus_error_responses;
+	u32 sysctl_icmp_errors_use_inbound_ifaddr;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;
 
@@ -122,29 +122,29 @@ struct netns_ipv4 {
 
 	struct local_ports ip_local_ports;
 
-	u8 sysctl_tcp_ecn;
-	u8 sysctl_tcp_ecn_fallback;
+	u32 sysctl_tcp_ecn;
+	u32 sysctl_tcp_ecn_fallback;
 
-	u8 sysctl_ip_default_ttl;
-	u8 sysctl_ip_no_pmtu_disc;
-	u8 sysctl_ip_fwd_update_priority;
-	u8 sysctl_ip_nonlocal_bind;
-	u8 sysctl_ip_autobind_reuse;
+	u32 sysctl_ip_default_ttl;
+	u32 sysctl_ip_no_pmtu_disc;
+	u32 sysctl_ip_fwd_update_priority;
+	u32 sysctl_ip_nonlocal_bind;
+	u32 sysctl_ip_autobind_reuse;
 	/* Shall we try to damage output packets if routing dev changes? */
-	u8 sysctl_ip_dynaddr;
+	u32 sysctl_ip_dynaddr;
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	u8 sysctl_raw_l3mdev_accept;
+	u32 sysctl_raw_l3mdev_accept;
 #endif
-	u8 sysctl_udp_early_demux;
+	u32 sysctl_udp_early_demux;
 
-	u8 sysctl_nexthop_compat_mode;
+	u32 sysctl_nexthop_compat_mode;
 
-	u8 sysctl_fwmark_reflect;
-	u8 sysctl_tcp_fwmark_accept;
+	u32 sysctl_fwmark_reflect;
+	u32 sysctl_tcp_fwmark_accept;
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	u8 sysctl_tcp_l3mdev_accept;
+	u32 sysctl_tcp_l3mdev_accept;
 #endif
-	u8 sysctl_tcp_mtu_probing;
+	u32 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
 	int sysctl_tcp_probe_threshold;
@@ -152,43 +152,43 @@ struct netns_ipv4 {
 
 	int sysctl_tcp_keepalive_time;
 	int sysctl_tcp_keepalive_intvl;
-	u8 sysctl_tcp_keepalive_probes;
-
-	u8 sysctl_tcp_syn_retries;
-	u8 sysctl_tcp_synack_retries;
-	u8 sysctl_tcp_syncookies;
-	u8 sysctl_tcp_migrate_req;
-	u8 sysctl_tcp_comp_sack_nr;
-	u8 sysctl_tcp_backlog_ack_defer;
-	u8 sysctl_tcp_pingpong_thresh;
-
-	u8 sysctl_tcp_retries1;
-	u8 sysctl_tcp_retries2;
-	u8 sysctl_tcp_orphan_retries;
-	u8 sysctl_tcp_tw_reuse;
+	u32 sysctl_tcp_keepalive_probes;
+
+	u32 sysctl_tcp_syn_retries;
+	u32 sysctl_tcp_synack_retries;
+	u32 sysctl_tcp_syncookies;
+	u32 sysctl_tcp_migrate_req;
+	u32 sysctl_tcp_comp_sack_nr;
+	u32 sysctl_tcp_backlog_ack_defer;
+	u32 sysctl_tcp_pingpong_thresh;
+
+	u32 sysctl_tcp_retries1;
+	u32 sysctl_tcp_retries2;
+	u32 sysctl_tcp_orphan_retries;
+	u32 sysctl_tcp_tw_reuse;
 	int sysctl_tcp_fin_timeout;
-	u8 sysctl_tcp_sack;
-	u8 sysctl_tcp_window_scaling;
-	u8 sysctl_tcp_timestamps;
-	u8 sysctl_tcp_recovery;
-	u8 sysctl_tcp_thin_linear_timeouts;
-	u8 sysctl_tcp_slow_start_after_idle;
-	u8 sysctl_tcp_retrans_collapse;
-	u8 sysctl_tcp_stdurg;
-	u8 sysctl_tcp_rfc1337;
-	u8 sysctl_tcp_abort_on_overflow;
-	u8 sysctl_tcp_fack; /* obsolete */
+	u32 sysctl_tcp_sack;
+	u32 sysctl_tcp_window_scaling;
+	u32 sysctl_tcp_timestamps;
+	u32 sysctl_tcp_recovery;
+	u32 sysctl_tcp_thin_linear_timeouts;
+	u32 sysctl_tcp_slow_start_after_idle;
+	u32 sysctl_tcp_retrans_collapse;
+	u32 sysctl_tcp_stdurg;
+	u32 sysctl_tcp_rfc1337;
+	u32 sysctl_tcp_abort_on_overflow;
+	u32 sysctl_tcp_fack; /* obsolete */
 	int sysctl_tcp_max_reordering;
 	int sysctl_tcp_adv_win_scale; /* obsolete */
-	u8 sysctl_tcp_dsack;
-	u8 sysctl_tcp_app_win;
-	u8 sysctl_tcp_frto;
-	u8 sysctl_tcp_nometrics_save;
-	u8 sysctl_tcp_no_ssthresh_metrics_save;
-	u8 sysctl_tcp_workaround_signed_windows;
+	u32 sysctl_tcp_dsack;
+	u32 sysctl_tcp_app_win;
+	u32 sysctl_tcp_frto;
+	u32 sysctl_tcp_nometrics_save;
+	u32 sysctl_tcp_no_ssthresh_metrics_save;
+	u32 sysctl_tcp_workaround_signed_windows;
 	int sysctl_tcp_challenge_ack_limit;
-	u8 sysctl_tcp_min_tso_segs;
-	u8 sysctl_tcp_reflect_tos;
+	u32 sysctl_tcp_min_tso_segs;
+	u32 sysctl_tcp_reflect_tos;
 	int sysctl_tcp_invalid_ratelimit;
 	int sysctl_tcp_pacing_ss_ratio;
 	int sysctl_tcp_pacing_ca_ratio;
@@ -204,23 +204,23 @@ struct netns_ipv4 {
 	unsigned long tfo_active_disable_stamp;
 	u32 tcp_challenge_timestamp;
 	u32 tcp_challenge_count;
-	u8 sysctl_tcp_plb_enabled;
-	u8 sysctl_tcp_plb_idle_rehash_rounds;
-	u8 sysctl_tcp_plb_rehash_rounds;
-	u8 sysctl_tcp_plb_suspend_rto_sec;
+	u32 sysctl_tcp_plb_enabled;
+	u32 sysctl_tcp_plb_idle_rehash_rounds;
+	u32 sysctl_tcp_plb_rehash_rounds;
+	u32 sysctl_tcp_plb_suspend_rto_sec;
 	int sysctl_tcp_plb_cong_thresh;
 
 	int sysctl_udp_wmem_min;
 	int sysctl_udp_rmem_min;
 
-	u8 sysctl_fib_notify_on_flag_change;
-	u8 sysctl_tcp_syn_linear_timeouts;
+	u32 sysctl_fib_notify_on_flag_change;
+	u32 sysctl_tcp_syn_linear_timeouts;
 
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	u8 sysctl_udp_l3mdev_accept;
+	u32 sysctl_udp_l3mdev_accept;
 #endif
 
-	u8 sysctl_igmp_llm_reports;
+	u32 sysctl_igmp_llm_reports;
 	int sysctl_igmp_max_memberships;
 	int sysctl_igmp_max_msf;
 	int sysctl_igmp_qrv;
@@ -246,8 +246,8 @@ struct netns_ipv4 {
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	u32 sysctl_fib_multipath_hash_fields;
-	u8 sysctl_fib_multipath_use_neigh;
-	u8 sysctl_fib_multipath_hash_policy;
+	u32 sysctl_fib_multipath_use_neigh;
+	u32 sysctl_fib_multipath_hash_policy;
 #endif
 
 	struct fib_notifier_ops	*notifier_ops;
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index ebcb8896bffc..662804623036 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -221,7 +221,7 @@ struct fastopen_queue {
  */
 struct request_sock_queue {
 	spinlock_t		rskq_lock;
-	u8			rskq_defer_accept;
+	u32			rskq_defer_accept;
 
 	u32			synflood_warned;
 	atomic_t		qlen;
diff --git a/include/net/sock.h b/include/net/sock.h
index 5f4d0629348f..729fa16dd29f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -168,8 +168,8 @@ struct sock_common {
 		};
 	};
 
-	unsigned short		skc_family;
-	volatile unsigned char	skc_state;
+	u32		skc_family;
+	volatile unsigned int	skc_state;
 	unsigned char		skc_reuse:4;
 	unsigned char		skc_reuseport:1;
 	unsigned char		skc_ipv6only:1;
@@ -210,9 +210,9 @@ struct sock_common {
 		struct hlist_node	skc_node;
 		struct hlist_nulls_node skc_nulls_node;
 	};
-	unsigned short		skc_tx_queue_mapping;
+	unsigned int		skc_tx_queue_mapping;
 #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
-	unsigned short		skc_rx_queue_mapping;
+	unsigned int		skc_rx_queue_mapping;
 #endif
 	union {
 		int		skc_incoming_cpu;
@@ -411,8 +411,8 @@ struct sock {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	unsigned int		sk_ll_usec;
 	unsigned int		sk_napi_id;
-	u16			sk_busy_poll_budget;
-	u8			sk_prefer_busy_poll;
+	u32			sk_busy_poll_budget;
+	u32			sk_prefer_busy_poll;
 #endif
 	u8			sk_userlocks;
 	int			sk_rcvbuf;
@@ -486,7 +486,7 @@ struct sock {
 	unsigned int		sk_gso_max_size;
 	gfp_t			sk_allocation;
 	u32			sk_txhash;
-	u8			sk_pacing_shift;
+	u32			sk_pacing_shift;
 	bool			sk_use_task_frag;
 	__cacheline_group_end(sock_read_tx);
 
@@ -498,7 +498,7 @@ struct sock {
 				sk_kern_sock : 1,
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1;
-	u8			sk_shutdown;
+	u32			sk_shutdown;
 	u16			sk_type;
 	u16			sk_protocol;
 	unsigned long	        sk_lingertime;
@@ -519,7 +519,7 @@ struct sock {
 #endif
 	int			sk_disconnects;
 
-	u8			sk_txrehash;
+	u32			sk_txrehash;
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
 				sk_txtime_report_errors : 1,
diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6ec140b0a61b..1c79170538f3 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -15,8 +15,8 @@ struct sock_reuseport {
 
 	u16			max_socks;		/* length of socks */
 	u16			num_socks;		/* elements in socks */
-	u16			num_closed_socks;	/* closed elements in socks */
-	u16			incoming_cpu;
+	u32			num_closed_socks;	/* closed elements in socks */
+	u32			incoming_cpu;
 	/* The last synq overflow event timestamp of this
 	 * reuse->socks[] group.
 	 */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 060e95b331a2..4c068da5d085 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1744,7 +1744,7 @@ static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
 /* - key database */
 struct tcp_md5sig_key {
 	struct hlist_node	node;
-	u8			keylen;
+	u32			keylen;
 	u8			family; /* AF_INET or AF_INET6 */
 	u8			prefixlen;
 	u8			flags;
diff --git a/include/net/udp.h b/include/net/udp.h
index c4e05b14b648..2794e6b75f86 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -279,7 +279,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
 void udp_splice_eof(struct socket *sock);
 int udp_push_pending_frames(struct sock *sk);
 void udp_flush_pending_frames(struct sock *sk);
-int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size);
+int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u32 *gso_size);
 void udp4_hwcsum(struct sk_buff *skb, __be32 src, __be32 dst);
 int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
diff --git a/include/sound/ump.h b/include/sound/ump.h
index 91238dabe307..c6ce23d2db00 100644
--- a/include/sound/ump.h
+++ b/include/sound/ump.h
@@ -26,7 +26,7 @@ struct snd_ump_endpoint {
 
 	/* UMP Stream message processing */
 	u32 stream_wait_for;	/* expected stream message status */
-	bool stream_finished;	/* set when message has been processed */
+	u32 stream_finished;	/* set when message has been processed */
 	bool parsed;		/* UMP / FB parse finished? */
 	bool no_process_stream;	/* suppress UMP stream messages handling */
 	wait_queue_head_t stream_wait;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 994bf7af0efe..647503be0999 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -30,7 +30,7 @@ extern "C" {
 struct io_uring_sqe {
 	__u8	opcode;		/* type of operation for this sqe */
 	__u8	flags;		/* IOSQE_ flags */
-	__u16	ioprio;		/* ioprio for the request */
+	__u32	ioprio;		/* ioprio for the request */
 	__s32	fd;		/* file descriptor to do IO on */
 	union {
 		__u64	off;	/* offset into file */
@@ -78,9 +78,9 @@ struct io_uring_sqe {
 	/* pack this to avoid bogus arm OABI complaints */
 	union {
 		/* index into fixed buffers, if used */
-		__u16	buf_index;
+		__u32	buf_index;
 		/* for grouped buffer selection */
-		__u16	buf_group;
+		__u32	buf_group;
 	} __attribute__((packed));
 	/* personality to use, if used */
 	__u16	personality;
@@ -89,8 +89,8 @@ struct io_uring_sqe {
 		__u32	file_index;
 		__u32	optlen;
 		struct {
-			__u16	addr_len;
-			__u16	__pad3[1];
+			__u32	addr_len;
+			__u32	__pad3[1];
 		};
 	};
 	union {
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 624ca9076a50..b14acb4de822 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -44,7 +44,7 @@ struct io_wait_queue {
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	unsigned int napi_busy_poll_to;
-	bool napi_prefer_busy_poll;
+	int napi_prefer_busy_poll;
 #endif
 };
 
diff --git a/io_uring/notif.h b/io_uring/notif.h
index f3589cfef4a9..e3f4f2462c4a 100644
--- a/io_uring/notif.h
+++ b/io_uring/notif.h
@@ -18,9 +18,9 @@ struct io_notif_data {
 	struct io_notif_data	*head;
 
 	unsigned		account_pages;
-	bool			zc_report;
-	bool			zc_used;
-	bool			zc_copied;
+	int			zc_report;
+	int			zc_used;
+	int			zc_copied;
 };
 
 struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx);
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index de95ec07e477..1b485f4041a2 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -123,7 +123,7 @@ struct lock_stress_stats {
 
 struct call_rcu_chain {
 	struct rcu_head crc_rh;
-	bool crc_stop;
+	int crc_stop;
 };
 struct call_rcu_chain *call_rcu_chain_list;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cefa27f92bb6..1f690da4a6e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -872,10 +872,10 @@ struct root_domain {
 	 * - More than one runnable task
 	 * - Running task is misfit
 	 */
-	bool			overloaded;
+	int			overloaded;
 
 	/* Indicate one or more CPUs over-utilized (tipping point) */
-	bool			overutilized;
+	int			overutilized;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index cdd4e2314bfc..a79464cba03d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -753,7 +753,7 @@ static int __init debug_boot_weak_hash_enable(char *str)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
-static bool filled_random_ptr_key __read_mostly;
+static int filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
 static int fill_ptr_key(struct notifier_block *nb, unsigned long action, void *data)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a5dae40523ab..cbf325c8afc4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -40,7 +40,7 @@ static const struct address_space_operations swap_aops = {
 
 struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
-static bool enable_vma_readahead __read_mostly = true;
+static int enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
 #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
diff --git a/net/ipv4/fib_lookup.h b/net/ipv4/fib_lookup.h
index f9b9e26c32c1..5c5b69e5fb8b 100644
--- a/net/ipv4/fib_lookup.h
+++ b/net/ipv4/fib_lookup.h
@@ -17,9 +17,9 @@ struct fib_alias {
 	u8			fa_slen;
 	u32			tb_id;
 	s16			fa_default;
-	u8			offload;
-	u8			trap;
-	u8			offload_failed;
+	u32			offload;
+	u32			trap;
+	u32			offload_failed;
 	struct rcu_head		rcu;
 };
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a6..24ebb76dc7b5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4729,8 +4633,6 @@ void __init tcp_init(void)
 	BUILD_BUG_ON(sizeof(struct tcp_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
 
-	tcp_struct_check();
-
 	percpu_counter_init(&tcp_sockets_allocated, 0, GFP_KERNEL);
 
 	timer_setup(&tcp_orphan_timer, tcp_orphan_update, TIMER_DEFERRABLE);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9d..7531e52c5e5d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -568,7 +568,7 @@ static void tcp_init_buffer_space(struct sock *sk)
 
 		if (tcp_app_win && maxwin > 4 * tp->advmss)
 			WRITE_ONCE(tp->window_clamp,
-				   max(maxwin - (maxwin >> tcp_app_win),
+				   max_t(u32, maxwin - (maxwin >> tcp_app_win),
 				       4 * tp->advmss));
 	}
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..47bf7dc201ab 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1015,7 +1015,7 @@ int udp_push_pending_frames(struct sock *sk)
 }
 EXPORT_SYMBOL(udp_push_pending_frames);
 
-static int __udp_cmsg_send(struct cmsghdr *cmsg, u16 *gso_size)
+static int __udp_cmsg_send(struct cmsghdr *cmsg, u32 *gso_size)
 {
 	switch (cmsg->cmsg_type) {
 	case UDP_SEGMENT:
@@ -1028,7 +1028,7 @@ static int __udp_cmsg_send(struct cmsghdr *cmsg, u16 *gso_size)
 	}
 }
 
-int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size)
+int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u32 *gso_size)
 {
 	struct cmsghdr *cmsg;
 	bool need_ip = false;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7aa47e2dd52b..803ca22eadef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -219,17 +219,17 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
-	u8		addr_signal;
-	bool		server_side;
-	bool		work_pending;
-	bool		accept_addr;
-	bool		accept_subflow;
-	bool		remote_deny_join_id0;
+	u32		addr_signal;
+	u32		server_side;
+	u32		work_pending;
+	u32		accept_addr;
+	u32		accept_subflow;
+	u32		remote_deny_join_id0;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
-	u8		pm_type;
-	u8		subflows;
+	u32		pm_type;
+	u32		subflows;
 	u8		status;
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
@@ -290,14 +290,14 @@ struct mptcp_sock {
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
-	bool		can_ack;
-	bool		fully_established;
-	bool		rcv_data_fin;
-	bool		snd_data_fin_enable;
-	bool		rcv_fastclose;
-	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
-	bool		csum_enabled;
-	bool		allow_infinite_fallback;
+	int		can_ack;
+	int		fully_established;
+	u32		rcv_data_fin;
+	u32		snd_data_fin_enable;
+	u32		rcv_fastclose;
+	u32		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	u32		csum_enabled;
+	u32		allow_infinite_fallback;
 	u8		pending_state; /* A subflow asked to set this sk_state,
 					* protected by the msk data lock
 					*/
@@ -445,8 +445,8 @@ struct mptcp_subflow_request_sock {
 		backup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
-	u8	local_id;
-	u8	remote_id;
+	u16	local_id;
+	u32	remote_id;
 	u64	local_key;
 	u64	idsn;
 	u32	token;
@@ -519,8 +519,8 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		__unused : 10;
-	bool	data_avail;
-	bool	scheduled;
+	u32	data_avail;
+	u32	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -529,8 +529,8 @@ struct mptcp_subflow_context {
 		u8	hmintac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
 		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
 	};
-	s16	local_id;	    /* if negative not initialized yet */
-	u8	remote_id;
+	u32	local_id;	    /* if negative not initialized yet */
+	u32	remote_id;
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 55f6e6917033..02c54a8b2f2f 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -25,7 +25,7 @@ endif
 
 KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
 KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
-KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
+#KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 
 ifdef CONFIG_CC_IS_CLANG
 # The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 289bf9233f71..92dff1fd4ac3 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -91,7 +91,7 @@ struct selinux_policy;
 
 struct selinux_state {
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-	bool enforcing;
+	int enforcing;
 #endif
 	bool initialized;
 	bool policycap[__POLICYDB_CAP_MAX];
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..ebca489c729f 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -772,7 +772,7 @@ struct tomoyo_inet_acl {
 struct tomoyo_unix_acl {
 	struct tomoyo_acl_info head; /* type = TOMOYO_TYPE_UNIX_ACL */
 	u8 protocol;
-	u8 perm; /* Bitmask of values in "enum tomoyo_network_acl_index" */
+	u32 perm; /* Bitmask of values in "enum tomoyo_network_acl_index" */
 	struct tomoyo_name_union name;
 };
 
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 8dc61335f65e..dccd873b5bf8 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -257,7 +257,7 @@ static bool tomoyo_merge_unix_acl(struct tomoyo_acl_info *a,
 				  struct tomoyo_acl_info *b,
 				  const bool is_delete)
 {
-	u8 * const a_perm =
+	u32 * const a_perm =
 		&container_of(a, struct tomoyo_unix_acl, head)->perm;
 	u8 perm = READ_ONCE(*a_perm);
 	const u8 b_perm = container_of(b, struct tomoyo_unix_acl, head)->perm;

