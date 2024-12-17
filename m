Return-Path: <linux-kernel+bounces-449612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487679F5175
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127AC7A4316
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337C1F76A1;
	Tue, 17 Dec 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="faVa79fQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C461F76A2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454538; cv=none; b=mffnLmHnDmHsOcxomRdXAw+2eJXzrkMVo+zC51X+JCOKorC/JnmonacMXnBv1KVPHz29Dtyh58M9ML7GBBTmvPYNZ6FczezNsyfzV0LucMQLubYpdsoPnXVleWUuXETNRZjtQmuPhXL6qlom0Er3w/5M5fkk3MroPl5KY51YvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454538; c=relaxed/simple;
	bh=XzT/xUZAUanRvCOhUsAPqlePaF6oL7aiyeWhFHrlYwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxuGgDakWeR0J7rBtgYn3YoKoKtPLnwzD4M9JjK31jTpK2y58/Fl8Iv7ocUmxup91/jcUkyYxFqr+djqoQH56JxaL2Xd6jUss1IkRjtSItIhWeSIgIr9l1k5fq88d1ePNqtXtIoSyi9giJVOHLymEW4/Z1T7vjsZmiq4rn23HWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=faVa79fQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728eedfca37so5692732b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1734454536; x=1735059336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq9UHSArzdY1x5xMk9wsFWdAq1adG27eAgZz0mkA3mM=;
        b=faVa79fQ75B1lWKXauw3tya+hVu/RD9KU4iAUd5sjzXRkHQ+ejhunkvJpdyh5xhiUS
         WdGr/mqywvMMtKPvYx6N0N10xdsU5Vz8nJA1ZaPEvzKs6xozhouX2J7XQ4oMxdoIJlYR
         VRZ7BDzzmOknUAsJMlnuRCFSKY6ow4/imJU3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734454536; x=1735059336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq9UHSArzdY1x5xMk9wsFWdAq1adG27eAgZz0mkA3mM=;
        b=d06VwbIQKkQzjLLM6raal0zTME183RzppCJgXENhf4qxIRAwF2SkCH1TY1je+2nx+6
         r7/tGo+7cDax5vmULvWWB1WVZ69YxdVYLSP0ktceizqwmm0eM3hlvNms66RDv5/zoEa7
         kvZu9Vb2QqYoEUbBIHn8G5rkUtufIpExLb6yhvH8cFigw1LiuM4usFMKgCb3K6oRFmAZ
         KPhaGySRS3OEV5dpdp2Rdm6BM52FZfnaqNOqsz0OTdEDrvbjUAFsSRYUZVLSv9HUJ56G
         WdRGREYiQc/QUjl2ZtvX5Tl4FPc6+DdXa2G32BJb0hQva0foQ91Wu1najcmCEF9oitmB
         PrPA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGhyPrB4fRepMqup+uz6CAjOd5OAHYSzECF9kLye250BWiXmg8LC9A19wcUZ/NF2lGHS5Bn6EqfMaE8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZhQKEsbfhk3ZDUSzykLcx9Tb49tT/JOUXjRIaUgcOGYsCkIx
	uqZcsmeIQQ3UZQVZqGL84DuQp/eyPKLQowQ5dhhGWyi6smWArS4Zxk+b1WbD6kyzdxziKsb/7Ud
	11/NhZRJ1+3H3gNTDdQWFsYj6TN1OHiAPP6heUw==
X-Gm-Gg: ASbGncvQVNZ1ozM3DDNKKlGz3CAujfgLW16R7TJljowP3K0g/1UtBUhYgewdcU5/0nx
	Vbe8XRhhPy6r8HNpPYU8BBHP+Tbfzg9TtHjKaEg==
X-Google-Smtp-Source: AGHT+IHKncR9EoH0iJhXzbKgdPiVLUBVaha1G+ueMtYPu1wQd6YTTMUeYDXJTRwatcecZhKP17PwXowcBskrWJlo5uU=
X-Received: by 2002:a05:6a00:4fcd:b0:725:ef4b:de33 with SMTP id
 d2e1a72fcca58-7290be785a3mr24935897b3a.0.1734454535913; Tue, 17 Dec 2024
 08:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-2-chenridong@huaweicloud.com> <eydeud7il4oe24xa4uvs2gistzrkphzq6bfiunwn73ipd2cxsx@kyisofhuivp6>
In-Reply-To: <eydeud7il4oe24xa4uvs2gistzrkphzq6bfiunwn73ipd2cxsx@kyisofhuivp6>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 17 Dec 2024 11:55:25 -0500
Message-ID: <CAFUnj5MdCj-TqvnuOaxBDRWSXzPo=WHO6-FN8ZQHz7S+2V1H0Q@mail.gmail.com>
Subject: Re: [next -v1 1/5] memcg: use OFP_PEAK_UNSET instead of -1
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, 
	mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:27=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Dec 06, 2024 at 01:35:08AM GMT, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> >
> > The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> >
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thanks for cleaning this up!

Acked-By: David Finkel <davidf@vimeo.com>


--=20
David Finkel
Senior Principal Software Engineer, Core Services

