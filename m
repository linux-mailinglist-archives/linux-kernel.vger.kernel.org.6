Return-Path: <linux-kernel+bounces-246121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE392BE1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AE1B2DEA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67A19CD18;
	Tue,  9 Jul 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eIzA8XJL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451C19CD06;
	Tue,  9 Jul 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537551; cv=none; b=Fz+lVeHbMrI6a0q012JejyZug0SbA+mFOdliN+HRdQSbDM44AJw0JfAGgwnjocYLvF0b2JHdv//DO7DkoVirXKzsWHv1UVYaqpikq9o0DYeiAHOsG6A3WAYuJhk5Db6LJkcDQeTJPGBc5+pjdSExTPnc8Ful3af37n4P2n+lNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537551; c=relaxed/simple;
	bh=7KdeIUNPQsG0ykPqrhHdQv+6oei5r5cewGe9Q/8P314=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o2dWNQIdn3hjWFSOV1QF4zTx1ubszTD33Ws7K0s1hFPsZ9I2gDTN4pwa2XpZjdKCZ/helaA/SuQ08lCk7fpuymnVnVb1nCQ9HgdUMIEs5TXTpMOSgiYodFGnQLIX4XRxBJkzIlN7TzZbo6yD+5l9BNcFTymzoIKN0NeMIxyUMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eIzA8XJL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C004A41A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720537548; bh=dr+FHBndTm677S+33kFUBxiFu4NosuJH12ccmibY21o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eIzA8XJLh3P3z/5hP4lrSoDlSCA9VT0aJ7t6V9gmHL/efl2Pvhafgw+dsljohMkf1
	 Z7BFfJG6HJewJlTBr7+hTEa9wpyasb3TUFaWXz9d/8oZ2NbioEj3+epuvTYvanwnB1
	 MPXNYjIho4YNXfOpnz2QDuMrXQJ7WlIu8MwRRHJRhz8f0tCk4cv7C3yeEtbFTQsfzF
	 1GcV8SsjmksyhyUFHw/mJ1d+T92GGrVOyJouS+z2zpCH8vKxet4xhtb+9TbrFdE9wv
	 xCe/kxI4bp+rSzOi/8wZUjpzc5Is/nS9kR7iDHZDzfL8KQhf/x2KvF0oW8fMCZZuSl
	 mLpp5EYvgu85g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C004A41A36;
	Tue,  9 Jul 2024 15:05:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,
 Ingo Molnar
 <mingo@kernel.org>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, Wenyu Huang
 <huangwenyu5@huawei.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bilbao@vt.edu,
 Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>
Subject: Re: [PATCH v2] docs/sp_SP: Add translation for
 scheduler/sched-design-CFS.rst
In-Reply-To: <20240707195047.14359-1-sergio.collado@gmail.com>
References: <20240707195047.14359-1-sergio.collado@gmail.com>
Date: Tue, 09 Jul 2024 09:05:47 -0600
Message-ID: <87le2a8v1w.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> writes:

> Translate Documentation/scheduler/sched-design-CFS.rst into Spanish
>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  v1 -> v2: Corrected typos and added a note about EEVDF
> ---
>  Documentation/scheduler/sched-design-CFS.rst  |   2 +
>  Documentation/translations/sp_SP/index.rst    |   1 +
>  .../translations/sp_SP/scheduler/index.rst    |   8 +
>  .../sp_SP/scheduler/sched-design-CFS.rst      | 277 ++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/scheduler/index.rst
>  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-desi=
gn-CFS.rst

Applied, thanks.

jon

