Return-Path: <linux-kernel+bounces-569770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14FA6A745
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46ED746001F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38BD1DF755;
	Thu, 20 Mar 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bFENl3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202051388;
	Thu, 20 Mar 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477835; cv=none; b=Uo4wJGdep572yhYSGuORP2bjIKy95cd4okWnt7NkcSlp2l8phLeMh5ZQiVxPQEovpt0o/Vl8eogAltXj/qmmQ+XWtdtwgNrKXjhtis7+iHxBptI0REhGz32X1DwfdvR2lS37QFlWhDQEpi/VMklED1l2QnOFEhJEZKXOSyLQs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477835; c=relaxed/simple;
	bh=HgOwjnlAUewP8SAJu/g9z/qlSeumFvhqMtDK/+WW8LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJxdsSmuYDa+vCrcI2VYZ4jXX0yJBBbmjc+aZyXA4HiR3+14HqDn5akqu+Y9imEuxgZhlAgoZTG7F/AM2i2y9CWNmes3QFnqiN8UTV5X2ZINHHEki67MrZNii2cB/ibhSTlann41zPS5JE/j2Jkihn5YaewBCIShTYhkRmDamdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bFENl3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406AC4CEDD;
	Thu, 20 Mar 2025 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742477834;
	bh=HgOwjnlAUewP8SAJu/g9z/qlSeumFvhqMtDK/+WW8LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1bFENl3uvFQ4E/3fVjVyRk5hYOzEmq+SHHmMSOhklsg0dq6yXpyTlaN0FJ7P9LS9P
	 o3VMx0sciKN20bBacYkshwa02qVNN2oDwjwufUz0kBgHXr/OizmZZojuvUex4WN4tN
	 WLz53tiHNLnfgJjesquYZ8CVqwDmcmEQxfHKIfoM=
Date: Thu, 20 Mar 2025 06:35:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Subject: Re: [RFC v1 0/3] Live Update Orchestrator
Message-ID: <2025032015-urgency-partake-9dc1@gregkh>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320024011.2995837-1-pasha.tatashin@soleen.com>

On Thu, Mar 20, 2025 at 02:40:08AM +0000, Pasha Tatashin wrote:
> From: Pasha Tatashin <tatashin@google.com>

Note, this does not match the author and signed-off-by on the actual
patches themselves.  Please use your google.com email address to
send/review/work on this.

thanks,

greg k-h

