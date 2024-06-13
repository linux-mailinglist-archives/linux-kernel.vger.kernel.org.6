Return-Path: <linux-kernel+bounces-213245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECA907306
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A3C1C21847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E981428EA;
	Thu, 13 Jun 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="icV0J7Hq"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDA17FD;
	Thu, 13 Jun 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283535; cv=none; b=bUcWsa55i5pXPCV5kTty7QNHJmosk89mzofkkRSj/PeOWZcVa2A7FQ8VLlhMB498i9/BV5PkoNSwGOP9qJebnhHIxt2XQSoQdSOYvAdvTunh9J+WEWQGveVcsRZZHkORM6iIdNgs41qcuhlf5bFz746NBdoD28m3okIy3Ar285E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283535; c=relaxed/simple;
	bh=tWI3gdk+WrvZLTS8KEyzUHKDurn7010dk0ls5SdUK7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivsguES9MHXnD4RE2vw9dgY40BmxeZ1XDLfltf+mmfavL4+gpmgifvbIwcm5HIpCYLvSldgVhz/RUUJVWh6YEl2GGZozbK8Fyv7SGEB97GqokeK6Lvzlw7zx+NuytNJlC9Mlna/vrwAUw/WtY3V2ECAHSSo8wg6wD1LZnh6PHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=icV0J7Hq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 527C145E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718283532; bh=akvXv+r87NNy8UUX+Qd788OiN5+P3VpuPDd+bJrE1qY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=icV0J7HqBUbKNB9ZPQy1r8wLbFpLYdo/147BzI0jh/1ruBu6hhciKMM152RaB6VUg
	 axKQPIGX0rKpgJL0uX32FveGZ0A83wHqeCj+iTZq3r/JoTCi0/x7NY4VLPABkN1Cge
	 ds4t+TUNij+VPOYXUMSTKupSM+Ht68qauoxK3ta+68pZO30wDA474Hqwm8abDUbBPL
	 JaEPeaQ3mAlr7hYa6kLWIpDTkumlgwYiAZcUmyzh7NF1PVp7PYpc/OtAA2ILbgvI7z
	 CXQxvCpoSduNU1rk/mGqeYj/qo5LgFe3lwXp3c4bQpMdP9HJHAEpYwFc4qnpixHWhv
	 OJmbTuXr+3dDA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 527C145E07;
	Thu, 13 Jun 2024 12:58:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 Cheng Ziqiu <chengziqiu@hust.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts: add scripts/checktransupdate.py
In-Reply-To: <43d7cf37-8f7f-4004-a5d1-15fcc9189016@hust.edu.cn>
References: <20240611131723.53515-1-dzm91@hust.edu.cn>
 <87plslonqu.fsf@trenco.lwn.net>
 <43d7cf37-8f7f-4004-a5d1-15fcc9189016@hust.edu.cn>
Date: Thu, 13 Jun 2024 06:58:51 -0600
Message-ID: <87v82dm22c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Linux kernel does have coding style for C language. Any reference to 
> python coding style?
>
> I can refer to these materials to revise this script.

We have never defined a kernel coding style for Python; I've generally
just tried to stay as close to the C style as possible.

If you are making other changes to the script anyway, you can adjust
coding style while you are at it.  I would not bother with additional
patches just for coding style at this point.

Thanks,

jon

