Return-Path: <linux-kernel+bounces-211463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B39051EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA651F285D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD116F284;
	Wed, 12 Jun 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZsXjaFex"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FF16D306
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193770; cv=none; b=E7zS9fOgHS2WyQBJal9G1Mjao8alEQK+yecyQIZEyKqNdnnzR+fkIsZKBWjI77tGZ+TTKvycmZJRwVUD9F4nPqTd27bP6egEAsSvcHXORfRRNKlFJYE/VACir5joc5EHgwCDdpc3oOBysAe5R4hvuZztKMhbbHQDWm0Iln9uKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193770; c=relaxed/simple;
	bh=mL6cvqeW+xRR7/gR0vCFleXEVve6zwKquscdx7tNoCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZyNkqVqPFo4sHkHEasH9WeSCo5ZEy+VMr+WT52ypl61KNF9cYTcSq2rm1bE4MxanfF/Ii005jzgS4zjzE3oTtDyDlWZNgO9zd3rEgEUEqOuoD9ZPZh1Be0T1vNlhfs9lKZ2pZmXWYki9gwQLTWllSfO64aUP39Z4MZrhk3WtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZsXjaFex; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mL6cvqeW+xRR7/gR0vCFleXEVve6zwKquscdx7tNoCA=;
	t=1718193768; x=1719403368; b=ZsXjaFexFUJKWMSpFF3w+dj6C0o61yNuUHpppkHQscqAMcZ
	WI14zfhjFOM8rLph5vMgrODJjVJ5pJ84220pKyw/xsih3xN+FSzrvSUe9fvco/Jlnjtoo3+NLlOuV
	U6UOc4dt+BYDEfOVTA2jZtbyq2IE46EwFG3L5UULG1HhStZX4FY/sGqB8ZIr7g8M40KgPm55ojepL
	BaBE8pTnFWUaoUA8SptTDyYjogsZbrrRYBis1piAN6PpN9SisKEUYAUPozU9d8Pgrb6tOE8+ab/1/
	vWSKZBLyfX3Duo1orRf1xbqagEywKeQeGAIzJLr7vgVER25lCwY4YE22Y6z4jQbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHMgZ-0000000AEXv-1ybR;
	Wed, 12 Jun 2024 14:02:39 +0200
Message-ID: <49c2fbdc91d128c5249d50d016d97c8e5162f7b7.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/2] devcoredump: Add dev_coredumpm_timeout()
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, 
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Mukesh Ojha
 <quic_mojha@quicinc.com>,  Jonathan Cavitt <jonathan.cavitt@intel.com>
Date: Wed, 12 Jun 2024 14:02:37 +0200
In-Reply-To: <20240611174716.72660-1-jose.souza@intel.com>
References: <20240611174716.72660-1-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-06-11 at 10:47 -0700, Jos=C3=A9 Roberto de Souza wrote:
> Add function to set a custom coredump timeout.
>=20
> For Xe driver usage, current 5 minutes timeout may be too short for
> users to search and understand what needs to be done to capture
> coredump to report bugs.
>=20
> We have plans to automate(distribute a udev script) it but at the end
> will be up to distros and users to pack it so having a option to
> increase the timeout is a safer option.
>=20
> v2:
> - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
>=20
> v3:
> - make dev_coredumpm() static inline (Johannes)
>=20
> v5:
> - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> in include/net/bluetooth/coredump.h
>=20
> v6:
> - fix definition of dev_coredumpm_timeout() when CONFIG_DEV_COREDUMP
> is disabled

Got to v6, heh.

I still don't think this is _right_, but I guess I'm OK with giving you
rope to hang yourself ;-)

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Seems like you really should've CC'ed Greg though since these things
usually went through his tree, so if you want to take them through yours
he really should be at least aware ...

johannes


