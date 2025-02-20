Return-Path: <linux-kernel+bounces-524250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD415A3E124
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752323BA540
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246220C494;
	Thu, 20 Feb 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oPM6Dbpc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171920C034
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069633; cv=none; b=rNAQWYrUBmraBSdz5Ojc9Mn86oKnLnBrQ2oSsrPqtAbOfModNMRs+Oa927y21FE0LzgG/0ZYmy8UShzkUlaXXH677O5leHO071+vfZn5Aa3c6RvFy5+waKBbnoVg1pjlZ6/kyewZqUknZtLQhhuu1dCV5teKO71X9dz1N2Qu2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069633; c=relaxed/simple;
	bh=eSBNTn4Wei7MvSd7KTecAx4Wv8JIaBEaD1KQ7IcmbDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6N206/8ojPvxk2FRfE55WcpCkAX5AqsSVqjQS3HEd4Q8IlrIW/sF4bMq/KVPEEhf2yJhk0KBPM/EC3aBLZtfNOKtvfalHXytT3PTgtbHbZD6fkf8o6SvHQRqz0oZHt4Wr1Haad4NM9M0gPw16JyiGn6/EZwSCqfCMoCo2B38FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oPM6Dbpc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso11897715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740069629; x=1740674429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ULQr0sXJ+T57rYA6unBEw0SRnUfX3L+nBpEtFm34hbM=;
        b=oPM6DbpcgQzVlBX59AEA021448KJV7QdUesUQy/vSug6hIqZsYW1thhsWXF0Zl7ZnG
         1iIUXPyOO4kOmZKHeNs2j46/j5Qo5OZXzJ+Nm3LiKowvm7nha+efCmk5acvRw4rW0L2B
         bUOzFiSWKIZhv5Ss5U8PYRCsArM2xjsRGa7R7NEciPzipVrjsqFZEqk4/ZvAzPmMRQjb
         PaemPpqouP8lVQb1idfHSsRTRWH6uVg9yJHbK0Sej/ulN2be8bPpNSN5jg/uQSD7NY/z
         9svDNyQSdwULHhQJyctinq1aY6Xm2Kb6PL9CL+A1bS0HUw6PHTHnm5LwvyuT3CNceTBL
         p7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069629; x=1740674429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULQr0sXJ+T57rYA6unBEw0SRnUfX3L+nBpEtFm34hbM=;
        b=hkwsxCFMKGSnto7Kr/fzcyPS78I7RQbLBR5UIsZZiwU5icEfrgvTZ6FpFA/vjd/wxF
         BFqI4Agok8Pu48eziv7L2uJEQUoOWhC7OfSnlUY59gOvVj1Ox+pDo5IvT2q0EQkieuI/
         fhMxQ+AXjLNkrtvW+VzlEtSD6Bx/y5yy9fD/AT/8trP/bpmiPRkrNAiBAuGSuR5bu1OV
         9oCTZfW0w02hjc6evX95W/tPwcmWJ1kccjtVv1tlEi3dXnm9kmNBKj+YA7GAgTsu6EP0
         y1FKeZDyaH0Ae6KIVlpqXO7Mv649nUu+Bpq48JfNUh3HtWjX8hsbgrQszLzM1Yw4j6hl
         wWxw==
X-Forwarded-Encrypted: i=1; AJvYcCWuf1CeODNZjcGTnet2BsG4guuavh+cnWD83Jp3mN5/51hf1aphR+vI3S/i2Z6dHVbcomH52NiVjOwvEuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGB1JqKEia4m/pl+Z2//UvmsnOudTr3zNum9SsS39owGaGqUp
	KUqhavGZCgRU4C0u3irfps0jomE4qg1pVEUYf8yGAQ+DKncg6XU/Y5YdVRqRGcM=
X-Gm-Gg: ASbGncsRIekPFNHnZClE4OAd6H+enM0Bx0QVUjbFo5Q4N+a8WkZwo5HIqIZNgqz8RwQ
	lUxS+PannkW0a/NuFham9OdzbrlTgDmV0VJtA8f6v8QBwbDxzmtMLZ7+38Z/izflB1TUrADXAnP
	VcHzVYssKUvehCUW6LqbXpXeIoQZTbohEWevGYeFCT0Yp1Zlnw6fiPtSUaHA6FiT61FYYPw/6/W
	cns+bhWviduqPf6qYX7RY/bwBvQX3nGScW6Ym2KO7/IUwk43j82pLuFmse9jU0Y2cCrnJQkG6TH
	M4nSNFrOs3BRBG5P28tfhjDi0DIz9oUoKT6LbRG6Go0ZAmOJPIIQqVOvUZ011GyyBUF30fA=
X-Google-Smtp-Source: AGHT+IHSMvs2kzmsmKiQHxZFyIcYPymD0uCa2DDj89kJ9d8q2/htWsAaOvyyBs/FSYI9s7/vlQ3GgA==
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d023 with SMTP id 5b1f17b1804b1-43988bbd481mr201896195e9.11.1740069629081;
        Thu, 20 Feb 2025 08:40:29 -0800 (PST)
Received: from ?IPV6:2a02:2f04:6203:2100:5146:3c6d:da37:b887? ([2a02:2f04:6203:2100:5146:3c6d:da37:b887])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439a416caeasm25629165e9.18.2025.02.20.08.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:40:28 -0800 (PST)
Message-ID: <d1e4fead-d486-4836-a48f-8421571b8ed8@tuxon.dev>
Date: Thu, 20 Feb 2025 18:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: renesas: rz-sysc: Suppress binding attributes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250215131843.228905-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdW4sN6x5C7iQgiZD=Vmzg=BA1v+WjS7aapXmuM2_y8JvQ@mail.gmail.com>
 <CAMuHMdWwzwHnZazp79q0R7n7MjKDQXRH_RqRSmNd1vdN_9JTqA@mail.gmail.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWwzwHnZazp79q0R7n7MjKDQXRH_RqRSmNd1vdN_9JTqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 2/20/25 18:37, Geert Uytterhoeven wrote:
> Hi Claudiu,
>
> On Thu, 20 Feb 2025 at 17:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Sat, 15 Feb 2025 at 14:18, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The matching data for the rz-sysc driver is marked with __initconst, which
>>> means it is discarded after initialization. Because of this, attempting to
>>> unbind/bind the driver through sysfs after system boot can lead to "Unable
>>> to handle kernel paging request at virtual address" errors due to accessing
>>> freed memory.
>>>
>>> Since the System Controller (SYSC) is an essential block for Renesas SoCs,
>>> suppress binding attributes to prevent them being exposed in sysfs,
>>> avoiding potential issues.
>>>
>>> Fixes: 1660e5ea6a3e ("soc: renesas: Add SYSC driver for Renesas RZ family")
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> i.e. will queue in renesas-devel for v6.15.
> As the offending commit is only in renesas-devel, I'll fold the fix into
> the original commit.

Sure, thank you!

>
> Gr{oetje,eeting}s,
>
>                          Geert
>


