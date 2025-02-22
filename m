Return-Path: <linux-kernel+bounces-526836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B98A4041C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E044D4238EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0C38FAD;
	Sat, 22 Feb 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7zbexuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E023D76;
	Sat, 22 Feb 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184041; cv=none; b=NVs7kZxQxYnxC4xURGZ084UzKLK8wsxoTcZuQo7UZP0IwEjihTHGNsIAgImwkuE5K7ooDNVRpI88oMck13f/8wyFOQREuR35QkvlpGmdcZgZZf8hdKVY15JKx7PKJFUwYrLpjhPB1lN1RvfvNUdxmP6Xo/aeJd8RUx3ZS6J1meQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184041; c=relaxed/simple;
	bh=tZ0SZ2h0lupVTrjrV46ivmRxyl8eqzDth8gxsVrl3os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbDhouY1NmRA9vdtUuiY1AIn2QnknmL2/7QR+vB3UOGKGakPQSfde9NKkL9H2PFEdrTtu5wTQdR1A7FWdcyIS/RklUO7Zw1Tv+9//0GtrWwwZMBMmpSks62cYM46PYRHgbGOFVniUQRgjWvvwmVhsbr9vwHvdddlutKjWvYcEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7zbexuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E29C4CED6;
	Sat, 22 Feb 2025 00:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184041;
	bh=tZ0SZ2h0lupVTrjrV46ivmRxyl8eqzDth8gxsVrl3os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7zbexuy6+Of72hFqDLqmKfueKOOnAQSJHqmMtwxiENuAFTwfBMzgB9NqKf9f8+dv
	 AZG2myMv9GAYcvPgbNfcONbn7YauCXafnjAoULkpnFObDw4Sd1EQeBFot+m+LW7/cK
	 WlMZfLxG5w+D99R1aR2Ah4lXB3ILdoZCfDswdSCm0yK5MFQ5FQFhpNfioHVC77tLgD
	 LyMF3nKW04aNv3PPz0OTrXJ3MFl8lxAA1xO7hsI5g5vy84ihRv6rZFaBFDN4Pp8mJa
	 cGfk1Tj8VyYu/o1cz8xlz4mWTLAobmqn1BavzmWN27ga/dC/9GmR6dRd+UQ0kbC887
	 S+nNAILeLke9Q==
Date: Fri, 21 Feb 2025 16:27:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Harshal Chaudhari <hchaudhari@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow
 defination.
Message-ID: <20250221162720.48eadeb8@kernel.org>
In-Reply-To: <20250220102954.609564-1-hchaudhari@marvell.com>
References: <20250220102954.609564-1-hchaudhari@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 02:29:54 -0800 Harshal Chaudhari wrote:
> Non IP flow, with vlan tag not working as expected while
> running below command for vlan-priority. fixed that.
> 
> ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0

Thanks for the fix, one nit - please add a Fixes tag to the commit
message. See https://docs.kernel.org/process/submitting-patches.html
for the exact format of the Fixes tag we expect. The tag should refer
to the earliest commit where the problem could be triggered by a user.
-- 
pw-bot: cr

