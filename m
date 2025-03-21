Return-Path: <linux-kernel+bounces-571398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23547A6BCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7624218915B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86813C695;
	Fri, 21 Mar 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdnK0mPS"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7412D758
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566414; cv=none; b=tLFlaMzBIdQcO4g8/Y8u6xprOnCiIXqMtyGHV5KcxVUEcncBQbmaWuciaPxhS4CNq0LTjwGgeARUnimledB1GiI3HXc/5k+Z3EUK/4V7F4O3G7rZPIAUUgwTBwyslvbzIPjXXq8DKnPWjprDOBtYJQ2icp5L6d2jFy98EP2z36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566414; c=relaxed/simple;
	bh=FrV+bDqB1tLxVykOuhmGdQwc/M3ZynizoVZrL3TV5sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N81ynHU7dPou/poS6EyJdkaXgjUYHp3CgNuRG3zU0ur2hpBO/Q+O9JxjOl/iH81s8DIsoHOY16z/XfzUEV0BGVMUcGT2PAfaV8FFR7hXVdwRK4ICf6NL5reIJ6cdX3MQs4hl/1KxT9dk4MLs/jgjbdyoV+9o9YQ1eiTf45BZmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TdnK0mPS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ab85402c9so156f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742566411; x=1743171211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rdyxkiadn/5T3WYrYH0qVA/Z6DnwQVizjdYlS/XfmA=;
        b=TdnK0mPSTpMY/vhBDrpLfM+jb7KzDKO8MmP9cjqF3luwd4YHddXuO8hTAKmaPMc17x
         z7iOhfp1Y0xg53hyNoJFirI6Be5y/RmGW6CpifB8OIMv6WNQnHbCMYk0pjf6XB0aVBKi
         x9b0MLvWPKwGTvtBeru2IyIjDUBdyqThMyFjx40zpVSl80XzpjA4QBaCKGmlUE0V+L2u
         IAUq1iSrSN5+lSUrfOmBVs31O4blwSlA/RJR7KI2P7zjL/McBeUrsVdOnbWg3twcxQL8
         gm0q7jc8TVbQ1UmybcG18lZSPoWjdeZfITBxq/QeilahYAPrHBjsGEjqNQsIPeP94CQf
         9MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566411; x=1743171211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rdyxkiadn/5T3WYrYH0qVA/Z6DnwQVizjdYlS/XfmA=;
        b=TTZaikC+zHe4NnuhgvUSFg0IyOiLtxAUWV/fAvBrZVW+pS2ZFOrBsd+jwCtPsXw/q/
         EnEOfnTtXGzqIJaKEhOggPxpKkGeRkKdqkZ3jaDJlWDX5xfPnHZmWX9e2RG+EosApU4c
         8xVdf9PhU3MfYcodDpg2ubpeeezFLfRmyranfGtacBx3SMyy3r2ShXCc5NPTogJ38cOk
         YAuUY0TOOat4WRxiqnmjzJEHIdwNnthiRs6JwvG/OhDmLHvUIrE/LHsZMPPRYpgJ/oMI
         pac2Ey/27neMS1P2HDloFDpR2yaULzASB5+pk/0jTlsknZ0xtC5WZtFbI/HxnbpVrwHA
         w/6w==
X-Forwarded-Encrypted: i=1; AJvYcCX3cVkkQzFtkUDapqB7QjcyMpIi2Y5lhiV7iD6VO/FGbihfIG+2C3YVVyPeffSZDbK7L4ADGod310wjS0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xXLifXptGp/a7DHhMoDc/3mXffWmIOSeQNgGw5m+x13IzmvD
	1MRxp1oOohIcIBvV+eO7qf/JQNT18TZ7on+2gLzJFnF1YYqpnrKzr60Sv/X+/dICoEro4cKjCCH
	Z
X-Gm-Gg: ASbGncutPtDO+fHD2jzZU4hUmD8++4yXNF6qXFdNcfcx56x+Fc9drgxIdLzSOr2gurp
	u6sb/bnepZh8GPWVuiNbPRXUqltuaDwti8Qng+vmjuCk8IcKs/oFtJTrMw9BMI5NZndN1IrU8FF
	4Iq1MaobwADsuDmnPbm3werwP8+hVRQdnz9VKZmms0/grDsbX41wSg63HwQjG194owcon6cvNAK
	amSbUuG8X7Odh/rMoA/fV6fjcLCPVtNTUpugBpqPGizKlJlnZQpqU2B7uu5SkAeLTsdj0JCk2F+
	93HL1vm7KfWqQ9ng1mwKYpY5qy7spQ3A7071ZulJMD+4ZVlUQ8cd7hJMVF9QcXLjpsgtp7BHkzS
	ItNNlBYp3u7j1NYIqlHRN63OHwWqNnwI1dZ+a2jdAZOfA7bSjGedJmd35YCzs
X-Google-Smtp-Source: AGHT+IHsVVOmA7WlwUcfsWQI7Vx5L2vYKwzVZKcT6mDdvsGKiJ+a/4JzzLFh+HqgxXEPyHUExoARyg==
X-Received: by 2002:a05:6000:1a87:b0:391:42f:7e83 with SMTP id ffacd0b85a97d-3997f940614mr1490523f8f.13.1742566410785;
        Fri, 21 Mar 2025 07:13:30 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b83sm2526258f8f.33.2025.03.21.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:13:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:13:27 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Mark Brown" <broonie@kernel.org>, "Grant Likely"
 <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is
 DMA safe
Message-ID: <20250321151327.4c8f8d4c@mordecai.tesarici.cz>
In-Reply-To: <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20130205142128.2E28D3E1265@localhost>
	<20250320124330.480d652d@mordecai.tesarici.cz>
	<ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
	<b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
	<db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
	<efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
	<06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
	<38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 13:41:52 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Mar 20, 2025, at 19:39, Mark Brown wrote:
> > On Thu, Mar 20, 2025 at 05:30:01PM +0100, Arnd Bergmann wrote:  
> >> On Thu, Mar 20, 2025, at 15:42, Mark Brown wrote:  
>[...]
> >> >> It also seems that the copy happens in the regmap_bulk_read()
> >> >> path but not the regmap_bulk_write(), which just passes down
> >> >> the original buffer without copying, as far as I can tell.  
> >  
> >> > Yes, writes don't need to do anything.  
> >  
> >> Can you explain why writes are different from reads here?  
> >
> > I think there may have been some context lost there while replying?  
> 
> I found the answer now: at least on common architectures (arm,
> powerpc, mips, ...), doing a write from an unaligned buffer
> on stack or in a shared data structure won't cause data corruption,
> but doing a read into that buffer can end up throwing away
> data that shares the same cacheline.

That's right. Additionally, any cache aliasing issues are irrelevant
for a write. Yes, there are (were?) some processors with a
virtual-indexed, virtual-tagged cache. Thank you, Arm...

>[...]
> >> - the way that spi_map_buf_attrs() is written, it actually
> >>   supports addresses from both kmap() and vmalloc() and
> >>   will attempt to correctly map those rather than reject
> >>   the buffer. While this sounds like a good idea, handling
> >>   vmalloc data like this risks stack data corruption
> >>   on non-coherent platforms when failing to map stack
> >>   buffers would be the better response.  
> >
> > IIRC that's there to support filesystems on SPI flashes or some other
> > application that uses vmalloc()ed buffers, it's definitely not intended
> > to support data on stack.  If it does anything for stack allocated data
> > that's accidental.  
> 
> Ok, then the question is what we should do about callers that pass
> in stack data. I can send a patch that adds a WARN_ONCE() or similar,
> but it would trigger on things like 
> 
> static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> {
>         return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
> }
> static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg, u16 val)
> {
>         return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
> }
> 
> which happens in a number of drivers but is harmless as long
> as the driver doesn't actually try to DMA into that buffer.

This sounds like we should push the WARN_ONCE() one level deeper, into
the DMA code. That's a good idea, actually, because it's always wrong
to do DMA to a stack address, not just when SPI does it.

Petr T

