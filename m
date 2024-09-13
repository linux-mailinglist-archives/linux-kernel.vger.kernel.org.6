Return-Path: <linux-kernel+bounces-328874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570A978A33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EE31C21BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA81474C5;
	Fri, 13 Sep 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="cRH/R3ts"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906034CD8;
	Fri, 13 Sep 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260560; cv=none; b=jPg653eCt8aKP8f+E/B8XM0+sIbvmlSpOx1VTYohPSnsuZeJYosRxi7FATR2qX9OYsBpTkgfjLsJ61pypr5esuI/o7u6/ivKlZEKFAh/SaOjtvNIf8LghbyDrOqLghkQ2xWVTgE/DzG32HVVLkxXBUKDzzUp1KGckuTfymrhFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260560; c=relaxed/simple;
	bh=dHXqkzDI7fPL8ZL5DnwKxcDnMyhXfuzk3DFIXV7jmeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b03PGqfAwYZYy588uvelismLzvA3FEvQP+xcrmpgT/jgdKf9YsLzxBI1xv4Cm/MaY311klKdR9rXWK8fRxBuEbwFHysqRDq+iNvU/yUX51GDqlVZ+NRw2jPRCQ2Gxl0cWbVG9CayahitXvbjzIpcGZuMNrwW7qJtzEJ6v2Mb2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=cRH/R3ts; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Message-ID: <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726260547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MCfVmDv2PMAfKS4DqZ7boOBF/67quVC8bAWfhKn5uo=;
	b=cRH/R3tsgk8hVC8/dJZP4ofYSbcpfoH/ir2UND8thoROjEK0BnbqxAhDojRaeYijCgdI5N
	fJYc4zar8FE15sb9Nj4p0FczFfD5EjaOjtSidd9UieLlUPtDC3Ztry/aZj4jy13qKRUii4
	rDSjEvxTCgRDLq22eQXwaiRK5J9W07I=
Date: Fri, 13 Sep 2024 23:49:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
From: Konstantin Andreev <andreev@swemel.ru>
Disposition-Notification-To: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <20240910184125.224651-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2024 20:49:06.0959 (UTC) FILETIME=[602821F0:01DB061E]

Casey Schaufler, 10 Sep 2024:
> ...
> The lsm_prop structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> ...
> index 1390f1efb4f0..1027c802cc8c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -140,6 +144,22 @@ enum lockdown_reason {
> +
> +/*
> + * Data exported by the security modules
> + */
> +struct lsm_prop {
> +	struct lsm_prop_selinux selinux;
> +	struct lsm_prop_smack smack;
> +	struct lsm_prop_apparmor apparmor;
> +	struct lsm_prop_bpf bpf;
> +	struct lsm_prop_scaffold scaffold;
> +};

This design prevents compiling and loading out-of-tree 3rd party LSM, am I right?

Out-of-tree LSM's were discussed recently at

https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp/T/
https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp/T/

but it looks like a final decision to ban them is not taken yet.
--
Konstantin Andreev

