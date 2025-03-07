Return-Path: <linux-kernel+bounces-551529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F552A56DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF5E17554B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229C23A9B0;
	Fri,  7 Mar 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I4oqhGnF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A321D3CC;
	Fri,  7 Mar 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365003; cv=none; b=hO8WBTBcxwxyA172Pq5TBVJ9AjBwaobLsAJn0Rxhh3m2kDao6Q/0M9d0HoFhhv1PJIra5WuIPwudLY6Ry/arDpdLvRXD83rB0JziZc4tJumSzDeI//Wm6+s19wKuc9wcGXi4FzkxAHIDFeiILJ+7U54IzIVdnGxP7HJyMXhGLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365003; c=relaxed/simple;
	bh=K8HOEPkM8BGf8JiU1lLwa4bU/W0KtoTk2lcpxC7pdw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFLFCqm8TOJvN0BhcWH3QdKJzUroTyzh5QLn0jwDCqrPmSMRC9WpzURF1snhy3Xhwb4b0Lhx2UFOaqgqvmitoI02t3ADTf182qKNP6vf+DM5He7QjRD92XioNeyKNAfpccF3S4JWyw8MgTO7Pp2EZe6oH2YnVa6FCyvBIzI2Y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I4oqhGnF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+zux3vNrKVylfNizNy/WWasQu32aZ+dFbWzJsqoycQE=; b=I4oqhGnFhjcjSgioJ0GP00Nzev
	Q8QUeyFI+hSVOG0aepQGOGXT87gnLpqU1tTSI8GSsWabNokZlICm4bI0wJi5YRjQW9J2Ou/q/ylfv
	Xp3rLCSKxJC+brOwTfnAhp05S+RR8VEmeW0kR1h9BKJQBjwdW5xAIF1HrcVGOLv+Mwno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqaa5-003BwZ-DW; Fri, 07 Mar 2025 17:29:49 +0100
Date: Fri, 7 Mar 2025 17:29:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net 1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
Message-ID: <7b5c765e-c648-495f-99d2-6470a494923e@lunn.ch>
References: <20250306172306.3859214-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306172306.3859214-1-Joseph.Huang@garmin.com>

On Thu, Mar 06, 2025 at 12:23:05PM -0500, Joseph Huang wrote:
> ATU Load operations could fail silently if there's not enough space
> on the device to hold the new entry. When this happens, the symptom
> depends on the unknown flood settings. If unknown multicast flood is
> disabled, the multicast packets are dropped when the ATU table is
> full. If unknown multicast flood is enabled, the multicast packets
> will be flooded to all ports. Either way, IGMP snooping is broken
> when the ATU Load operation fails silently.
> 
> Do a Read-After-Write verification after each fdb/mdb add operation
> to make sure that the operation was really successful, and return
> -ENOSPC otherwise.
> 
> Fixes: defb05b9b9b4 ("net: dsa: mv88e6xxx: Add support for fdb_add, fdb_del, and fdb_getnext")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

