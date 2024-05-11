Return-Path: <linux-kernel+bounces-176388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7508C2F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BEC1F228A5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C340BF5;
	Sat, 11 May 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlJjFrpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B3224F0;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394634; cv=none; b=ZWmB/LHUouamYrPh+5gRa8aUnk0N34dpTQsTz+5lxQ7n/rAviAzzDAjGqoUWx4JSBSdwimVQn6ood3Zj8vJ0mCkP1ndnZK9I+q/Z2ILPyCXX8e0SqJYqubUEDhyp/kcqxlWEXp7dac04gb0Mud2umXzQHv65CvOieseDiMRwgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394634; c=relaxed/simple;
	bh=rUfvn5DMD3LEDfMMdyfVPa6M9zJbWco1ouLCzRLvIaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pp+bwmGwf9OFJa5NCjyqdlIHmk6wKPJXTudz4OdJUKD803NY4kAAdL7qeswDd6H2mgFIGJUulfIZGTnhm0/f/m70LOyGp8slBQi/IYy/AyaT+ysYI3UWvvr0orMHQpUu6DARuH5bfLV9GdQl2JpPbApDnJ/T5i8lsVjxG3vfXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlJjFrpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF7E5C2BD10;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=rUfvn5DMD3LEDfMMdyfVPa6M9zJbWco1ouLCzRLvIaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlJjFrpzXdyxyVH+J8WxNRYwPZkrNIY6P2yGDGsOUAftrRx30ThnVIt5imSaKRkgh
	 PHqaZ2muaENhH82GdKDI0gC6ofpN5jLbmNSsffNAtOLrsGBvHic9Oi095ifvoMweYm
	 f+6D0cztr4X9Gl1dpbkfTv5vmsVHBYn5NGCHXGqVrzikk0ZSo+nrz3Y3Es4ryMWL2G
	 Gqj87qTW87Z6ozo8AD/nLhrbxpFVVStXZfCcGuj+zlEB/JLuqkbM1FU+WIazJwqwHb
	 eHsqlbcjevZGzQm49FbXAuescPNTz+sQOyClA2bS7bZCB7wJNfv30oYMAs+TFD6ZO6
	 hqvZtc9aI+i+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE848E7C114;
	Sat, 11 May 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix overwriting ct original tuple for
 ICMPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463384.29955.8815078625887290807.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:33 +0000
References: <20240509094228.1035477-1-i.maximets@ovn.org>
In-Reply-To: <20240509094228.1035477-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, joe@ovn.org,
 jarno@ovn.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 antonin.bas@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 11:38:05 +0200 you wrote:
> OVS_PACKET_CMD_EXECUTE has 3 main attributes:
>  - OVS_PACKET_ATTR_KEY - Packet metadata in a netlink format.
>  - OVS_PACKET_ATTR_PACKET - Binary packet content.
>  - OVS_PACKET_ATTR_ACTIONS - Actions to execute on the packet.
> 
> OVS_PACKET_ATTR_KEY is parsed first to populate sw_flow_key structure
> with the metadata like conntrack state, input port, recirculation id,
> etc.  Then the packet itself gets parsed to populate the rest of the
> keys from the packet headers.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix overwriting ct original tuple for ICMPv6
    https://git.kernel.org/netdev/net/c/7c988176b6c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



