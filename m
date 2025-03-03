Return-Path: <linux-kernel+bounces-545314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E2A4EB92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66F41896CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97BE265CC4;
	Tue,  4 Mar 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/MnuYWp"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8A24C085
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112032; cv=pass; b=Yw5laPStZFfmGQKVA/yGKnXkQAxn7G324m/6qCxmiz4xki1d/JW16IQxjCgF64lw27TQzS7YHALdpccx9ujscAA+IB7EvowR0Nf7aetpKNlZRCtZxbY60Wf3o26d98bCWHjREYQRrZ53eIGletZ8LETzUxjv/P4so/aOH4LY6ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112032; c=relaxed/simple;
	bh=JbSwGZ/wELTrXO7XKmcWatlS3Iq75TQfCfzGJlDgLmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMFxXzvWXpldzO+5WfhYcrk5oC/mZaoIpMhPHxmlPO+VjTrpk7q8oYXFyrXIntHlNj28q8uhqdSQ67QV66G6Mabdw30+lPtKBn2JX2YEdQdwNn6RZyDpJKmN85F0Yz10CnhSWSd/fis9jZSIFpqTQGIpNoRf5ckd0UzyV+pfloo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/MnuYWp; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id BB6FA40CEC80
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:13:49 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gVt39BtzG2LD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:04:54 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 529CE42733; Tue,  4 Mar 2025 19:04:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/MnuYWp
X-Envelope-From: <linux-kernel+bounces-541766-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/MnuYWp
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id AFD6F41A5C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:20 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 8739D2DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:20 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A29189362B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA00211A28;
	Mon,  3 Mar 2025 13:09:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D461210F6A;
	Mon,  3 Mar 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007369; cv=none; b=bDUJmr8fvVgzGnKbytPUxyxdnwUsVMtwV/H1Di4q5hUllms9fVpZh99ihTtu1uWCrQXIrSKBW3O1/hBBaQq2LyW5aR9VRSXcoNlcHwcjw2mP40dzqpkp3/LAtCWvl4+Tn8r3VqV9IdhcuJ3kyLg2dTj+zFD5hNPRegzIjG/v7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007369; c=relaxed/simple;
	bh=JbSwGZ/wELTrXO7XKmcWatlS3Iq75TQfCfzGJlDgLmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUtjTSqB9FWPBEiS4zFl0avWunwnzYQ2c4e/VsWV2z1eXlTOKWkhIUl5fQZscFQWBK4T+5N1Po6KxReAKlMCo9NGuIsHsURt6l9lfkecV935FHWBQquw0S/KCBNgDuBh52hn8tRZMvCeSE8bbLCNO5qnoLzjEHjpuPy0kzjYUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/MnuYWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B9FC4CED6;
	Mon,  3 Mar 2025 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007368;
	bh=JbSwGZ/wELTrXO7XKmcWatlS3Iq75TQfCfzGJlDgLmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/MnuYWpZ+jM1e70sWmYC/TkbpFgpBP1KGu5+3x1ycK8eDZoU2nZf2ExnpbfvAzRf
	 5huGJlm7ZLITepdCS/G4XWoSqRFmMJCxNJzjiCSZueggl08czx6hFMDykLNHYHDsUz
	 yYCU9libF4wbdEWCfXnIUfKZQlqAQk3sdWP4OEkt5biqIAQMr/SDqbLKklor55o2uQ
	 gqs6BLB4shIfApD3HJEoOkRv27Jfw43/bpcD4PffCq9EUvn0CXLvI8AfNSwedtOLlT
	 ZGuDECMoxNcZHVOa8KnNL4k528OBzwr0k8EdmnTspvAcUt2jHu3kVQA/T7ahQZtsGL
	 0FeqcqQ117A5A==
Date: Mon, 3 Mar 2025 13:09:24 +0000
From: Simon Horman <horms@kernel.org>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next v3 1/2] net: hsr: Fix PRP duplicate detection
Message-ID: <20250303130924.GR1615191@kernel.org>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227050923.10241-1-jkarrenpalo@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gVt39BtzG2LD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716717.54919@wBHJB9QLkuhxHMlLlfq7aA
X-ITU-MailScanner-SpamCheck: not spam

On Thu, Feb 27, 2025 at 07:09:22AM +0200, Jaakko Karrenpalo wrote:
> Add PRP specific function for handling duplicate
> packets. This is needed because of potential
> L2 802.1p prioritization done by network switches.
> 
> The L2 prioritization can re-order the PRP packets
> from a node causing the existing implementation to
> discard the frame(s) that have been received 'late'
> because the sequence number is before the previous
> received packet. This can happen if the node is
> sending multiple frames back-to-back with different
> priority.
> 
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
> ---
> Changes in v3:
> - Fixed indentation
> - Renamed local variables

Thanks, I see that this addresses Paolo's review of v2
and overall looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

Please find below two minor nits.
I don't think you need to respin because of them.
But do consider addressing them if there is a new
revision for some other reason.

...

> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c

...

> +/* Adaptation of the PRP duplicate discard algorithm described in wireshark
> + * wiki (https://wiki.wireshark.org/PRP)
> + *
> + * A drop window is maintained for both LANs with start sequence set to the
> + * first sequence accepted on the LAN that has not been seen on the other LAN,
> + * and expected sequence set to the latest received sequence number plus one.
> + *
> + * When a frame is received on either LAN it is compared against the received
> + * frames on the other LAN. If it is outside the drop window of the other LAN
> + * the frame is accepted and the drop window is updated.
> + * The drop window for the other LAN is reset.
> + *
> + * 'port' is the outgoing interface
> + * 'frame' is the frame to be sent
> + *
> + * Return:
> + *	 1 if frame can be shown to have been sent recently on this interface,
> + *	 0 otherwise
> + */
> +int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> +{
> +	enum hsr_port_type other_port;
> +	enum hsr_port_type rcv_port;
> +	struct hsr_node *node;
> +	u16 sequence_diff;
> +	u16 sequence_exp;
> +	u16 sequence_nr;
> +
> +	/* out-going frames are always in order
> +	 *and can be checked the same way as for HSR

nit: space between '*' and 'and'.

> +	 */
> +	if (frame->port_rcv->type == HSR_PT_MASTER)
> +		return hsr_register_frame_out(port, frame);
> +
> +	/* for PRP we should only forward frames from the slave ports
> +	 * to the master port
> +	 */
> +	if (port->type != HSR_PT_MASTER)
> +		return 1;
> +
> +	node = frame->node_src;
> +	sequence_nr = frame->sequence_nr;
> +	sequence_exp = sequence_nr + 1;
> +	rcv_port = frame->port_rcv->type;
> +	other_port =
> +		rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B : HSR_PT_SLAVE_A;
> +
> +	spin_lock_bh(&node->seq_out_lock);
> +	if (time_is_before_jiffies(node->time_out[port->type] +
> +	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
> +	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
> +	    node->seq_start[other_port] == node->seq_expected[other_port])) {

nit: the line above should be indented to align with the inside of the
     parentheses on the preceding line.

	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
	     node->seq_start[other_port] == node->seq_expected[other_port])) {

> +		/* the node hasn't been sending for a while
> +		 * or both drop windows are empty, forward the frame
> +		 */
> +		node->seq_start[rcv_port] = sequence_nr;
> +	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
> +		   seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
> +		/* drop the frame, update the drop window for the other port
> +		 * and reset our drop window
> +		 */
> +		node->seq_start[other_port] = sequence_exp;
> +		node->seq_expected[rcv_port] = sequence_exp;
> +		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
> +		spin_unlock_bh(&node->seq_out_lock);
> +		return 1;
> +	}
> +
> +	/* update the drop window for the port where this frame was received
> +	 * and clear the drop window for the other port
> +	 */
> +	node->seq_start[other_port] = node->seq_expected[other_port];
> +	node->seq_expected[rcv_port] = sequence_exp;
> +	sequence_diff = sequence_exp - node->seq_start[rcv_port];
> +	if (sequence_diff > PRP_DROP_WINDOW_LEN)
> +		node->seq_start[rcv_port] = sequence_exp - PRP_DROP_WINDOW_LEN;
> +
> +	node->time_out[port->type] = jiffies;
> +	node->seq_out[port->type] = sequence_nr;
> +	spin_unlock_bh(&node->seq_out_lock);
> +	return 0;
> +}
> +
>  static struct hsr_port *get_late_port(struct hsr_priv *hsr,
>  				      struct hsr_node *node)
>  {


