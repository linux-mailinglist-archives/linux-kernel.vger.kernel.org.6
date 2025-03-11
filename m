Return-Path: <linux-kernel+bounces-556331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36CA5C423
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD873AFB19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAD25BAC0;
	Tue, 11 Mar 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebsx0eSt"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3F25D551
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704086; cv=none; b=ZDoeGf02HV5l1SoCsOndoyJ6ruBv8sZMxj/aUvWphHQgbSx9jXxpVzzyTqczckVNaZBGqEqErlvfXY4cDIj+lsXTvmxy/mbfr+r7ti7Vw0AJtCAgHmAmYAS1q5vJ2OqAxkC5l+uwsdp0LmmqAEmySURTdvrOKKFFFe4ZvvC1Md4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704086; c=relaxed/simple;
	bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwfzV3Crx3H+pPxwJnagBHnJI2o/w1iXA3HHo2RDd49TWPIAgfuYf0aM/d48G2tjLRxaQ9N93LvwAARt7lBdX3NGuTfJQ3JTIcHvoy6Kip3dAFQ1SW061qI9D9F+GLyo/zFadmuORDD0wv3Q5V/DG/9gmPV1skqFsv/GzUV2ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebsx0eSt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39143200ddaso1600004f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741704082; x=1742308882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=ebsx0eStJiZ5pRpBn1LGcNEhc9/ufzisag743zx7HByV9d6QSHMUqiwjqKgjpXT7oL
         2vU8+xXY9ImNkzAqhc+EvhfqYqXs/uWL2Taa6GmFvD3NYqbxPKKX1EoOzb1udEsEZeIV
         YJMzBGzfn2T/V8bTe6+UFGBu37NvTG5FEH+jse8qcaaAHoyMpnUgjuYM2e4fIXJ49Tif
         Ri8NcB5Eh5UfFSrSmJvTQbmlPNGjjZKPN9/+jzoXRz+g6N4StRy0oD6tgbLofE5XvswW
         GqO8Q6qMMwJur3txS14MNAJbQbBRMFnv8s11YyW0GvnX0T4BWus+07cA2MnUkpj/u27U
         sK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704082; x=1742308882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=f2Mv+O2BamEkNmpE9bXHTIMQFQUx6c/zZ+YVhPaqZ1Sb8pRJfzGwTF/zgmUx2QYeA6
         wqIPqWuX7WVX6HwCcn2O2e8lHSnXLLRpoPtvsnJVrfcOqPhwA3EHdtxYgZO0rBZ4QpjF
         Ocd6pUZbPgNHPcA9NghSb1PaVO46QtsPDym3j/ZrQrG77bp5xcmg5j6Wc2FefZzrQmM/
         iZbwBr6s5hAKUjWa0kOASCKkbxpjr9jepk1SFa9w/Sgxq9fHf3FwKT/Mb7Pz2aw18kp2
         yvMVdZqiogF6kQmKtFu6G7ik2i0RCdOoqkDbUSNj5lMi73J6jBWgOImBbhXiMqyebySz
         lL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+9l82JpISdALzKecMuaNUcH2Rk8U3Vf5WGZAMxRhZk9u0mi7NMsJ4JhsaHStF4PhZs/WSLrF1iUb3xug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPndQMffbf42U3K0uoewpKZGsUMa/0a5kD/XtB/tp8lyyaGAT
	bJS5+Jd+vWp1d4KbNUTASy57I3y/SRFkkadjh5pTdqSFx7PC22/5HA4iiWQeI0w=
X-Gm-Gg: ASbGnctxPdbgOyyLCMGNdIG1E7tbeXiDjxmUrXVx235LG/T5G34TvXMRAjsC9J2mJm8
	rZeRRu5cOMuEqGnVp3GOqtmdihhpbqSPu2hTrwxNzBaTHTwzOlwuOlBBxGEEed3+ZC0XIt1oVXu
	M7Wixne0niukzLCMrN6l+NC526wcUQeUzFYXdf33lFUy1aQsUHnekg9V1s+jZ9t5ADRX6DLtYEj
	McvS5WMfmQmQAchkKXCB9SPg3DJ7g2YaOrLUVU8RpYk1g0WQtRiQJ9unML6iJf7ithpclGlL2Cj
	O45xuEGO4QLQjoHg8tngTJ+t4fqUskqwpjNQZeJCDNYFbYe8Qwhi6NasfdKIU3xMozO2G01ZSVY
	=
X-Google-Smtp-Source: AGHT+IHedVj4RUj6sW41ewt21ZWFTQVrQn0/iCeA7D/35qQUSXCzs/EtRBqy+mOCc1u29u+Bx4/luQ==
X-Received: by 2002:a5d:584b:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3926c78f6b5mr4736641f8f.54.1741704082203;
        Tue, 11 Mar 2025 07:41:22 -0700 (PDT)
Received: from [192.168.3.33] (110.39.160.45.gramnet.com.br. [45.160.39.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18675615f8f.53.2025.03.11.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:41:21 -0700 (PDT)
Message-ID: <9a8b7634b123e82c3eaf278a5944feafd91279cc.camel@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biederman	
 <ebiederm@xmission.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Todd E Brandt
 <todd.e.brandt@linux.intel.com>, Jiri Slaby	 <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org
Date: Tue, 11 Mar 2025 11:41:14 -0300
In-Reply-To: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
	 <Z9AShs1dEO0jrgjL@pathway.suse.cz> <Z9AvKmM4Li57-E2E@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 13:40 +0100, Petr Mladek wrote:
> On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> > On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > > Hello, I've being working on some patches that help to clarify
> > > the suspend/resume
> > > of printk machinery. The last patch on this patchset address one
> > > issue regarding
> > > suspended consoles and blanking.
> > >=20
> > > This is a part one patchset that I would like to see merged
> > > before I send more patches
> > > that will rework the suspend flag (a global suspend flag istead
> > > of per console) and
> > > the removal of CON_ENABLED flag later on (I've created a function
> > > that will forcibly)
> > > register the console instead of using this flag.
> > >=20
> > > Please review!
> > >=20
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >=20
> > Looks good to me. I could fix the typos when pushing.
> >=20
> > Well, there is one more thing. It seems that the simple graphic
> > logger
> > was merged for 6.14-rc1. And the console_stop()/console_start() API
> > is used also in drivers/gpu/drm/clients/drm_log.c.
> >=20
> > It is actually the code which motivated this rename, as already
> > pointed out by John, see
> > https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> >=20
> > Well, I am going to update these two locations when pushing this
> > as well. Let's just get this change done.
>=20
> And I did as mentioned above.
>=20
> JFYI, the patcheset has been committed into printk/linux.git,
> branch for-6.15-console-suspend-api-cleanup.

Thanks to all reviewers and to you Petr for taking the patches and
adjusting the typos!

>=20
> Best Regards,
> Petr


