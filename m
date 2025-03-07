Return-Path: <linux-kernel+bounces-551273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DFA56A57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB34189B155
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0921B9F3;
	Fri,  7 Mar 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="muKROObd"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53B664C6;
	Fri,  7 Mar 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357666; cv=none; b=PuwpUESluO9hPXdUZ7El3vewJzepgFbnVO9YpHiPEt2T3o+026z2tPJUULpCgfRXKxN+PWVTLXPjErpFPyPAsh9loRK1mLSqOSit+mUzogKehOWZLjcIMyS9Te2knaPZ1i4LLvgiaUL2qB6QpM7cMCSzXlSYcCzET0aCPVXZuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357666; c=relaxed/simple;
	bh=/V8o8eBfEg6gD2LpNGYlIIbgvZgf5fRW9f89ZvP5Smo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7+uFfj8/Cj118R0nRrvRsoGsqTP03XDeXK5vhjHjMP9PZ/cdIiNkLGwsrXKD9oz6EjVaV+/IKK8vjd6R2reSfWVlOezppr81SAP8k+tGGTZH6FenRaqPNzov91rPEv6wg9mIk0X86BGNBHuGY4emyVJQ8CXRarjh5JwjrgvKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=muKROObd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/V8o8eBfEg6gD2LpNGYlIIbgvZgf5fRW9f89ZvP5Smo=;
	t=1741357664; x=1742567264; b=muKROObdnVFlxssOtUO2I/BxzPXmKgEY4d4xWB6eWUK6W9T
	WaNgBdRdJw6AO5/WULLhNna/ysFAfJqhTaM+F5rbqpUFNESUvla4mCpHdhanYYA4V2qlHcaayy+WX
	/tc2SZUyx7A7hUM18iDQDPFKV5LAzpL0cuxO+gXi9rN9TLDhDwu6lGqaP6eRDXh61bRiddtgb7PDL
	CvI3321vKwsrQHOfzKq6+9tNlFCoyTc4fJhQ7LGEY3djU6QbU+zAt9O+AzAbiQGiXV81th5LXcNXK
	skGz0abIf8UFqMHh1dwD7/wv/rHEGtNi+0eGSjsLcGAG8AL+t2BMht0XU8rgSGFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqYfu-00000003wBD-0iuU;
	Fri, 07 Mar 2025 15:27:42 +0100
Message-ID: <a3ad0b7e8b5e16ee25cbc692798c0858e55a1b0c.camel@sipsolutions.net>
Subject: Re: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
From: Johannes Berg <johannes@sipsolutions.net>
To: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Date: Fri, 07 Mar 2025 15:27:41 +0100
In-Reply-To: <20250214131225.492756-1-max.kellermann@ionos.com>
References: <20250214131225.492756-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-02-14 at 14:12 +0100, Max Kellermann wrote:
> When checking whether the edges of adjacent subrequests touch, the
> `prev` variable is deferenced, but it might not have been initialized.
> This causes crashes like this one:

[...]

I believe we also need this in 6.12?

johannes

