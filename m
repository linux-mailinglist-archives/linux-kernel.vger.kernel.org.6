Return-Path: <linux-kernel+bounces-408311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F19C7D40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C0FB24A56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE62064E9;
	Wed, 13 Nov 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYE+pgQP"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EE193403
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531638; cv=none; b=DbEQD3FCNNs+VW4/bYfYNv1J51Kp+6jlwP/9kkTpfFaxkCFtKrTDxdJODZ94ZRMwKpfmptAty3yI1vzF8RHwJiLqjSVXLMiShweW06Va+t3fMOCIuIEoAjndwbWe4TGmILHdcwZeHZgwHoJW5/3ovfi2Pt4Bw/SlDTFx7ObviRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531638; c=relaxed/simple;
	bh=NOoK9D08d1cD98HbmY/SNp8w7KIzcpck8xrQd3varsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRJgGvjMr39pTvVpuIHQJtfEiv+SW/QrmmoVY5qzJi6CE9iJlGTjsq5W8XwHJezHhaZN3R4pEVM8CI7lUerHvf1EMy76HnmBIaMqZ2RM3pztJeRPtTg17fJ2KYHGKIY62uH5NE9jF78obNWF8NJRIIh7nDtdpISJuPKUXICR+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYE+pgQP; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e786167712so4755852b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731531636; x=1732136436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOoK9D08d1cD98HbmY/SNp8w7KIzcpck8xrQd3varsE=;
        b=uYE+pgQP3/t8M6L1d3xuccl9w7w3HYL51ty/YyO7eKaxRQCX9MhK6Q3Tejdt3rZjNk
         m05JIE5+Ge2GWDTR7d3O9p2QSH6CjvUe6mcwqnk1zt3qg5pJMT0my8yZW50bQIM9b1yC
         XUxC59Dmwg3SvSANLRL83FxP8EGfYSyzXUQ4oDBpL7KlGmxYzukKFFmzNMgEEpLrUxgf
         3gmmsLdBvIoFRwxUaRsRrnr49ssdT0ojJD641gcZoAF1mmSv0MM4sVM6aqn7qG21k80w
         1+nJvSNg0aIYtwYlabv+lK4AJrfVm8WaSrHb/6ghydCS4Acw1Pvt6LHY5MridabitiYK
         rW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531636; x=1732136436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOoK9D08d1cD98HbmY/SNp8w7KIzcpck8xrQd3varsE=;
        b=pCobrCnEznHSUEZXC/mMyrJVIqcAKUCRi2gKKyxVKXRLjS4Ya2EcF1yJf1s72QdfXB
         MadybNsmt06iwFixWa4fMarM+1nsePgBR7jbigzSWATQs61YZ0b9c92kwDuVPzmQAJlF
         WGHpcitXA98ueH1LsZsT1ydtraDkFCXEVvsICy9+WaoEKY2obDj7cjWnxUB4Byda2rjM
         7DutdmYAAWw5G6xkzQUnqVZGgRPkvku//MEckvSbPVpRYowDUzOK6yRbCxl5SRSGb93h
         0VPoAt66E6DOuTMCiVbizWe4KwPH1PkAqSd4Cw+H3bs1wY9973WhiRQEvxLFLUCldm07
         NMRA==
X-Gm-Message-State: AOJu0YyyJ33bTCZ1bhQFdxmhY4tXGxBDzKGg9C52A9o8sSiSas9yonL+
	XDW+c0gCHOO1CMi+cefp3YjKE3tGUZ2pquW24w/W1SqlFYT9yttU23BvyLDKTmNKvmDu/DBxhH7
	NymjyJldwzRUbkS1EN7NARwRGW5SAtaUMTrii
X-Google-Smtp-Source: AGHT+IGOg+3FnfndG4XO5hwRGw7Qw0vuq3lkbM7M4AA3dEjEuYY6YxgBe8HlEwKg7bLeuOB09lYjGQH6ha88+nrTYnk=
X-Received: by 2002:a05:6808:3409:b0:3e7:b2b6:ee10 with SMTP id
 5614622812f47-3e7b2b6f045mr2784977b6e.12.1731531636182; Wed, 13 Nov 2024
 13:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZHvHUi0KpEW+M0k5A-9UfAGJzm++gzaaxdCbLsLFVQJw@mail.gmail.com> <SJ0PR11MB5678995E8E0B6B39509DB875C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678995E8E0B6B39509DB875C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Nov 2024 12:59:59 -0800
Message-ID: <CAJD7tkZGzVM53UWwp+u7UMYu4sumgJhVRhohMqiHP1=8PgTHCA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > Please just rewrite the commit log and CC stable (in the commit log,
> > not in the email CC list).
>
> I guess this refers to adding "Cc: stable@vger.kernel.org" in the commit log
> (as found from the latest mainline git log) ?

Yes, thanks!

>
> Thanks again,
> Kanchana
>

