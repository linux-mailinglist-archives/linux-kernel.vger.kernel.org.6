Return-Path: <linux-kernel+bounces-527841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A750A41067
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90286189365C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D786AE3;
	Sun, 23 Feb 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TGLyQF86"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028722071
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331403; cv=none; b=kQWvFkkE6oqkjNnOMbdIY1jF6FWNdWZk+/q4mhmoOXSgP6fIOtvPZPgv6h/ruLQYOCYdt0RXOgnH7fwFMx6NWjy2bJlEWK38R1uf4JU23BPQMQk6EUUplQwjZgYm/a73Y/P6pECcB6m7gRWE1YbyZoyAiBT0AZZbLEYQwzAe9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331403; c=relaxed/simple;
	bh=QUsRh1nNKsaGpisE5qYQAN8G+m4Dt7dYGrysT4Q8aOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CSemf2v5/g4C2ZWP53jRlG9sb1M8xUU+ewatMRcPhXV0fVZZOMeb4tu3CLN3qwS7Q70FoVEUYJlIX/cRW/aMbAsK4XKLc5g0sW/HX1ToUCDULW7m/3qLwnTeoMBZmYsFwMumfwbHwL+eFQRqvhgktfMkO02LALPK2mgPwJrvUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TGLyQF86; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=K6AjRKXMcIWJMvCoVF/pqk8NG+bDe1Eyhn9FmQ6hkCw=; b=TGLyQF86q3y0kgmA
	7kDjnh+juTG/N01uKOSWcTy0oc4muCtkAKxQ5BKJlXty/c9GyfqgzJm58bsslgaHiuzgAk3iOEUuq
	nn7CvoA2FfHKj+Ehpt833jax9ZwYihwYMEglRJy3/6eB7DBXoNGQkpJYtJPrguKmgIXcYf9Xb1EjX
	+CEDY6PKdFBv/BAceSnoSBOUnWA9IdnfOA+9juTTfJ+3D8Z7HT9RkHTyP2OxACDG8ysVIqicqhQHQ
	huVn+sXgMd9fQvgzaXIETmyCZvZyTLbAKsPnrZky/IVNZp70/B0PN2XTiownrQR5QhDe+w2T2yvkC
	gjqOnhjTFHudNJkWxw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tmFhF-000CQ8-2E;
	Sun, 23 Feb 2025 17:23:17 +0000
Date: Sun, 23 Feb 2025 17:23:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, david@rowetel.com
Subject: users of drivers/misc/echo ?
Message-ID: <Z7tZhYET41DAoHVf@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:19:52 up 291 days,  4:33,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I can't see anything that uses drivers/misc/echo - should it go or
is there something out of tree using it?

  I see where Greg moved it from staging into the main kernel
but am not seeing anything include the headers or call any of the symbols.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

