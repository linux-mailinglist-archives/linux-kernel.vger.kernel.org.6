Return-Path: <linux-kernel+bounces-416773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F19D4A01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71FAB20CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03171CDA18;
	Thu, 21 Nov 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPKu3jVp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2171C2DCF;
	Thu, 21 Nov 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181421; cv=none; b=Fa73iynfZ7Y/ql37/xppv21So3vIjMrHjIrh2Njdv6R2r8XVjgUeKGg0hoHSj5dH4IGXWb5sPxId5k/J3At+3u7cfl/SiBxyDK+5/uDdF9Oe2IhsmFZNWlriOp1JHtdj189IGJE3yNZH6L0slUtOuxDFyuJXua8h3of6HJryHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181421; c=relaxed/simple;
	bh=COpcEQ9LDIDz97efL8r3x18TgW5YqbYnr0/OQECbI8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AImcCBQkCa2RcoJa6yyb7sEDgw/LvMHEoJiRgUX0ljaA+F4aEIJEteLCp7bjXDz42IwZBZrR0oWuQ8dHy0pV1Dz9GRRulCzt3yM1+D+sr0Jx+1vAVVQ4jOmx0+coVr0PFvqpHNMxpUj+9DpmSS7/QbG7Ef6jFOpUWwBWC+19W1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPKu3jVp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da5a27771so697673e87.2;
        Thu, 21 Nov 2024 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732181416; x=1732786216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80PKBDEVtPQ4QjHxDlXlhwod1lEddQK+pje91L+duo4=;
        b=IPKu3jVpAVJYRX3jxTipS2Df2j7U+PfnypnFPXMSYLFe0Cac/cJYE/EE2W5uDLFj6d
         mh4ZaVVIO404PQ9TG5iXxVVkdszp+QNKpGu85/Gc9Gr/IrHtmubX5XI0WjgsXNef3tVk
         9iobfD5JxRYNcOLGgahgKvnMZ6gX8AeZvX3nyN4WTS75wCM7a2omCfklyLdccIYEgL27
         QkTc0GD1sTOzAzFa/YYCH/6jTnYRMmXccLlnjsrewNeJA+zIs2ICVl/OP2T1q5vqYvJV
         gG4xLsoku1tUfwY/VasDQ7RsVnrZiCFB+sVrK7sn1gxEWZ8vZwiGPOfzdqXHD5stxS9Y
         DvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732181416; x=1732786216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80PKBDEVtPQ4QjHxDlXlhwod1lEddQK+pje91L+duo4=;
        b=WM59bTHrnXyvBia5OjQ+jkgAfsVK2TAS6D1g4D+V9BD7+54x3KOzfD6SwNg0Cu6rYj
         10aScwrE88GdxFRzcAuy8R2MhxCCImCdqYU05U9ntPgO0QkGdbA0MTWTNeHdu4wnj4RG
         g1NKYQSMRDcD7NZM44FPMxl46f4Vwn7gP8bLnJjofMgA0b/tEbe/oGt3MzlnpP+b0iyp
         WiHwl7cSDSWCI68qpX09coPaAAQBWj/4Aj1RJgAYsRbsKs09x3aOTnHro01kaGRzgjmv
         hKdeoRqaTiePsFF7LUwgfH5b/ly3z8FJZguQfsXPE3IbGitUwZjbJBZOOZqNcG96oEmj
         elnA==
X-Forwarded-Encrypted: i=1; AJvYcCXXYTkThJEXlCXJsR1ITnvUXgfv4Ppqs+6Boivy+XpFILl4WiypblBjVGTFYuzvJw6Z24C0o3XwQ9emyW0=@vger.kernel.org, AJvYcCXlO+880/uzcrM9PWnRxTHk3SAEsVIU/js6sxZUFqzm0TGQl4PpYKNo5fhvGhIhVxShqAWhDiol/T/XmZYwur0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGcAjWKe7Q69ftasvC9nWA4n5RRZ3XNgxPzrJyXsf2w1S9MxL
	yKH5o5NEYKhip9wQb23fUUTSCbtqHyvQX6AywAQuJVO9E5SkvjjXz2FbaQ==
X-Google-Smtp-Source: AGHT+IFO7XMPmUFEJbv0KQ/GnA69E/7miUMRAVhpaTsMfUcJm2jpB17RpCNvA5HvAdtk+8JdkMelOA==
X-Received: by 2002:a19:6453:0:b0:53d:abc8:b6dc with SMTP id 2adb3069b0e04-53dc1327e39mr2549621e87.6.1732181416157;
        Thu, 21 Nov 2024 01:30:16 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd47838bsm903749e87.243.2024.11.21.01.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:30:14 -0800 (PST)
Message-ID: <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
Date: Thu, 21 Nov 2024 11:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local> <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Zz59qgqKruqnouTl@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Boqun, Matthew:

On 21/11/2024 02:24, Boqun Feng wrote:
>>> So if I understand correctly, what Abdiel needs here is a way to convert
>>> a virtual address to the corresponding page, would it make sense to just
>>> use folio in this case? Abdiel, what's the operation you are going to
>>> call on the page you get?
>>
>> Yes that's basically it. The goal here is represent those existing struct
>> page within this rust Page abstraction but at the same time to avoid taking
>> over its ownership.
>>
>> Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
>>
> 
> Could you use folio in your case? If so, we can provide a simple binding
> for folio which should be `AlwaysRefcounted`, and re-investigate how
> page should be wrapped.
> 

I'm not sure. Is there a way to get the struct folio from a vmalloc'd 
address, e.g vmalloc_to_folio()?

Regards,
Abdiel

