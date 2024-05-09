Return-Path: <linux-kernel+bounces-174817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30118C1561
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12671C214CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AB7F489;
	Thu,  9 May 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3TaCrUG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617277D401
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282545; cv=none; b=st4kgPiX17gk393fyVPpY0whckQVxAFmL0waYiOmbulNy9k6W+x3pxN7m/aINi+2gE4TUlZJWeTfMCd0+eVcOfB3dQHTi1e9k8A8+5M5yltdxr/yRCb6+GUicKuWnhBdfmSZRREOihi/Kk5Gmh53zDI8Anqwpuj2G5lH0Ne2hCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282545; c=relaxed/simple;
	bh=uhopRzx/XhZA35l03Dn7Eg/wIJKB5A+zw2Gz642p7V0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+eKxKlgvgwM2VxhVloI3ft6ZTUCzfnDFPUCc8tHQQCUOXgIuibRNWEDp67nkOX5xdPpREZaELRCBS4zITJ1kUcZ+XlCS9p2AcJLBdNF/J9dKb/sxpH1AHm2MT9mCFwpNLn+jIeLfHzV0+Z/KkTFddmhB96SVZCazcXNlpRRBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3TaCrUG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715282543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhopRzx/XhZA35l03Dn7Eg/wIJKB5A+zw2Gz642p7V0=;
	b=F3TaCrUGWivdmSQzzG3/s78xQKKPsNLxxSsDI0UxOBERwcLTqAsCqoTBDHU9qPKkjKKjhz
	zc38hwnUI/3WWTs633wX3CQfiDyANZAI9zOvaFD94mbJy8uU6Z54IiYl7shoroLHSKRRZ/
	mfCvwB95uBxuJdlZv+KEEcLcEuSWfPs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-GYLy5SiTOy6DDp6vog8HRA-1; Thu, 09 May 2024 15:22:22 -0400
X-MC-Unique: GYLy5SiTOy6DDp6vog8HRA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c865208160so999875b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 12:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282541; x=1715887341;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhopRzx/XhZA35l03Dn7Eg/wIJKB5A+zw2Gz642p7V0=;
        b=A8nRpjmvHra7stObtL3rbHpF45v/heaevJU/MwfCjBnnvFHo5q6T4o+NV1nm1wqeq8
         9bnl6LP5SYwnHfcjso4lwOUPhp2b1NFnjhVh0PdLqnZd8+yRtTQ7JT9GqvMrhDZmLl/s
         pwTBwUelVWlA8u+DeFibI0dDiCfXDf5xts6q3hQ5xSiJFYbtnti0DWuCHdHc0qwCgQZo
         +dRjGXOo7lD5YCKaP8coprkBTfrhmZHCOzlGoYBfJTccFErK2MUV+uz5A6qOGA5gCZNn
         U9b+3oTx5Ug6tjt1ByenNGtMs2Pb4CteHJJdUeeFFNWbNQem06MW5DV/Fhv7NOwFMrMz
         23sA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ghB2E5MrrCnmo+lRAvHufi4jdJdnsBHcOKap20JxNmh68HHaGTD9VENGAst9ejV/KGenG/v+yiQmp37XwDqasTTYW0Z5bjk9pRcH
X-Gm-Message-State: AOJu0YxsRhd9Rfpfo4SDB23wdpkyKE031/xdSVJvusKjfbD7QylfZbqG
	GfY7rFGnGdf5/x18tNkRVyieiVYXprnShlMEUeaOF9ymJrnRfr6JBqBu50W8SRTf3lg7z6oqY0B
	+vLIFbLMZ9uSjlV6fCGHeqojfsWJsDxHQM9sz16MUZPRI042lycwX/GoCPmOypyOUp9SO7w==
X-Received: by 2002:a05:6808:4283:b0:3c6:943:e0ad with SMTP id 5614622812f47-3c9970d1ad3mr513022b6e.51.1715282540909;
        Thu, 09 May 2024 12:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEccDULG+OZF6F4EJARtsc9vrHVxtHz6I2M4b63CQsYPYrrGuQ3VvnMKHvMeG3kq524mAJ8NA==
X-Received: by 2002:a05:6808:4283:b0:3c6:943:e0ad with SMTP id 5614622812f47-3c9970d1ad3mr513003b6e.51.1715282540588;
        Thu, 09 May 2024 12:22:20 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a1689c479bsm297046d6.57.2024.05.09.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:22:20 -0700 (PDT)
Message-ID: <0abb541a45fd46aefb67d0a5dfd869230d8e3d95.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Thu, 09 May 2024 15:22:19 -0400
In-Reply-To: <877cg4ppd5.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
	 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
	 <87plumxz4x.ffs@tglx>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

So uh, apparently amazon decided that instead of using the shipping
address I have in their address book that is marked as "Default
Shipping Address" that it makes much more sense to sort all addresses
in the address book alphabetically, and then surprise me by sending it
to the first address in that list. which means the adapter got shipped
half way across the country and it's probably going to take me until at
least tomorrow to get a different one here, sorry :(.

Will get back to you with this info as soon as I can

On Wed, 2024-05-08 at 12:30 +0200, Thomas Gleixner wrote:
> On Wed, May 08 2024 at 10:38, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> > H! Lyude, Thomas, what's the status here? From here it looks like
> > we
> > were close to a fix, but then it turned out to be a bad fix -- and
> > afterwards nothing much seems to have happened. Did it fall through
> > the
> > cracks, or was this already fixed and I just missed that?
>=20
> I'm waiting for more data still.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


