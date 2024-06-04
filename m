Return-Path: <linux-kernel+bounces-200485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C48FB0AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BDBB20B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D3145353;
	Tue,  4 Jun 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKD1lqPL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKD1lqPL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C0446CF;
	Tue,  4 Jun 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498885; cv=none; b=N1CZsld6odnRgEk5xcVerTpiXzxmBvqYdnQ/yOPkSRxPaGVhwpOVsw0TH2YcTmYvQHBxlfkW/iwQFzZPvR0yXVNvS1rkf1vkwe8KagzJ7pyJ0JR8Q/vpAw4URYR2FHpGaIyCvD2U/hOHo2Idvq4MXLf3r7/WLJHkSOClgcDtkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498885; c=relaxed/simple;
	bh=xQl84Bz6i6t84pFop+EKJ6Lb9wvhYFoJDyum/U/ejmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSL+rXTNUkDSA6BEFgN96FirVA57xOPdIdIlixbAoWbbwDuv1rGE0SaOI5ttslnX/jAtwsrhpW7Snmt+iB99GklUZI6ai+5TDBP/rwacLd6x9CksqXykWj3PtbgoKvQhnMnGwgew9oWO7AMp6RCuMn+RgsMfYawK3BgdmDQYalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKD1lqPL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKD1lqPL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC9521F7E2;
	Tue,  4 Jun 2024 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717498881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncbBv9ofqW4X/fA8YLBC5mZ6O1tNZhTDcxQoH0UpwWI=;
	b=HKD1lqPLQ6P9SScD2XwXOPR9faXqZF45wh4ll7wCToPIWnPc+Zv/vROPpVACwRZ0jGfQqD
	onAOX+Lm9o9I99u2PKaraxkxbdPd2JPGm3HEiGw+5qmKhpTEhjhv7aVK6EsI2QrlZsuY08
	5XiJoxiYurz+LZ06xgOvVYv8jZUsBnY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HKD1lqPL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717498881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncbBv9ofqW4X/fA8YLBC5mZ6O1tNZhTDcxQoH0UpwWI=;
	b=HKD1lqPLQ6P9SScD2XwXOPR9faXqZF45wh4ll7wCToPIWnPc+Zv/vROPpVACwRZ0jGfQqD
	onAOX+Lm9o9I99u2PKaraxkxbdPd2JPGm3HEiGw+5qmKhpTEhjhv7aVK6EsI2QrlZsuY08
	5XiJoxiYurz+LZ06xgOvVYv8jZUsBnY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A03BD1398F;
	Tue,  4 Jun 2024 11:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ClYjJAH0Xma7SgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 04 Jun 2024 11:01:21 +0000
Date: Tue, 4 Jun 2024 13:01:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-35941: net: skbuff: add overflow debug check to
 pull/push helpers
Message-ID: <Zl7z_Yz0cIbsr53Y@tiehlicka>
References: <2024051919-CVE-2024-35941-1a9e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051919-CVE-2024-35941-1a9e@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC9521F7E2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+]

AFAICS this patch is not fixing any security bug. It adds debugging
output and triggers a WARN_ON with CONFIG_DEBUG_NET (which could panic
the system with panic_on_warn which has been broadly considered a CVE
material by the kernel CVE team).

Please drop this CVE.

On Sun 19-05-24 12:11:35, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> net: skbuff: add overflow debug check to pull/push helpers
> 
> syzbot managed to trigger following splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
> Read of size 1 at addr ffff888208a4000e by task a.out/2313
> [..]
>   __skb_flow_dissect+0x4a3b/0x5e50
>   __skb_get_hash+0xb4/0x400
>   ip_tunnel_xmit+0x77e/0x26f0
>   ipip_tunnel_xmit+0x298/0x410
>   ..
> 
> Analysis shows that the skb has a valid ->head, but bogus ->data
> pointer.
> 
> skb->data gets its bogus value via the neigh layer, which does:
> 
> 1556    __skb_pull(skb, skb_network_offset(skb));
> 
> ... and the skb was already dodgy at this point:
> 
> skb_network_offset(skb) returns a negative value due to an
> earlier overflow of skb->network_header (u16).  __skb_pull thus
> "adjusts" skb->data by a huge offset, pointing outside skb->head
> area.
> 
> Allow debug builds to splat when we try to pull/push more than
> INT_MAX bytes.
> 
> After this, the syzkaller reproducer yields a more precise splat
> before the flow dissector attempts to read off skb->data memory:
> 
> WARNING: CPU: 5 PID: 2313 at include/linux/skbuff.h:2653 neigh_connected_output+0x28e/0x400
>   ip_finish_output2+0xb25/0xed0
>   iptunnel_xmit+0x4ff/0x870
>   ipgre_xmit+0x78e/0xbb0
> 
> The Linux kernel CVE team has assigned CVE-2024-35941 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.1.86 with commit 8af60bb2b215
> 	Fixed in 6.6.27 with commit 1b2b26595bb0
> 	Fixed in 6.8.6 with commit fff05b2b004d
> 	Fixed in 6.9 with commit 219eee9c0d16
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-35941
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	include/linux/skbuff.h
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/8af60bb2b215f478b886f1d6d302fefa7f0b917d
> 	https://git.kernel.org/stable/c/1b2b26595bb09febf14c5444c873ac4ec90a5a77
> 	https://git.kernel.org/stable/c/fff05b2b004d9a8a2416d08647f3dc9068e357c8
> 	https://git.kernel.org/stable/c/219eee9c0d16f1b754a8b85275854ab17df0850a

-- 
Michal Hocko
SUSE Labs

