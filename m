Return-Path: <linux-kernel+bounces-311352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EA9687F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998AFB23CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3B19C567;
	Mon,  2 Sep 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxkZ2uEA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520819C54C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281443; cv=none; b=tMV3Ngk3aSzFKiKgsYJ6/pa656omRgPTQ6MM3i5W1LH4Kevf8w2a7JF0+zK9wuQu53KtVHlDhLhJlgpG4vW5kLqPWFObw4wKOy1+LY0A5/pKMxYM9dDgdbBx75ioKTtfy5GQBOGhA9IdVBOUFotwG8uaQDQRli0AF7cEJ0KYdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281443; c=relaxed/simple;
	bh=wD5WU3DlnkE7/7Bfl8rAc7JhV2d5QZiHeuH5VnmG+cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jysISEeaw8GZzGH7QnJLN4u/7LHHTU3qIrVqy7n6rIXgejXQ2AfiTUUeMKShg5agIINPBmhOhWMp6fo4V8EbHyCPouBZgIXKJEnONe09ndmO88D+zngJC2uTnl3eOeZjaq6pS1fznkwajU4/nKMIy2L+zbqsPU0S7JQjNYjvVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxkZ2uEA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so25342735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725281440; x=1725886240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJnA695QquNw8bx5Anxd5qcaf3vOLJ39okwGPUweS4M=;
        b=UxkZ2uEA/9UB5h6JPCMpbsGnUfuWFDaZ7kQlDCCTAD8mQgwI7uS/vBNCWf1uJZVkVq
         knaH1RPEnb8xvItz4rMHcq1JfBefOUp/vAy58kNqifKRVG0WbiRkClgpjH9y4Wa943y0
         39cchcI8lpJ3ms91jWIkvQffxWufciH7C+ocv+4l6GlZe3MwzJeCxf263GbV1MpZC3/c
         +GovL6DVbpVtnJZGHGfWovPUc4JjgQ2To/Eh1TVrXNnM7bENMlrCWunW1lDX8DHxHtWd
         F1tt5P8LLiw5DcSn/SjKR0EDJQxogOrDpBicdP0E57i9JdhFtVXFzW3E6sMwTSIuQYjv
         hyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281440; x=1725886240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJnA695QquNw8bx5Anxd5qcaf3vOLJ39okwGPUweS4M=;
        b=jFIK2+6IAXOcLsoLwQwycH50G5gaip4Lqe9pmqiCuQ/r5DbPNCQ+LTdIGsv/4pkqY7
         KNmCcSzO1SQG0aDp9YVbSyKp+QH0widQA+ZR5h+zda16VvWRGVvNtuB6PWrFAxont5/3
         kel4Q5DMnsO+wqJXaU+i7NMGM4DZwdO+HTNpYKjbzY7KkR0bdq5wfFXbJr2GyrfpQ8pY
         yF4IAKh5yxem7kWGDuYd7W+Ma2Qw3alF8JZ9ymbyKDml56UbcGW3KNM/AeMHDBwvhhwk
         x1eEohRl3VoF//DIK4ZKiKKRt6G32oxc0oNebvt2yk5bOadoWQ1Rek+/5gPf+8+Nn1/p
         ba/w==
X-Gm-Message-State: AOJu0YwNo1EscqDO3n3oxJmGC9va6dMa938/+D/yQuFhcQV7N8Tpb45v
	AARbLcB2LsHV4hYuioKyhGW8U5ce+hVoxLdKB/a8jVGvxH+kW1GtAS0gJnVKMSvCpZqc49CWocK
	woqemanurPQHSqAwrzrGv4CTnxks=
X-Google-Smtp-Source: AGHT+IGl2Hyv4O5xpl36uVLZmtMNRiTNdWMpn6NqPMT5Ksd1v+YZvlf+G6Do8Mnr2xG30azwwspDKl7Q3RcMiOc2vNs=
X-Received: by 2002:adf:fa0b:0:b0:374:c35e:de72 with SMTP id
 ffacd0b85a97d-374c35ee267mr3249650f8f.2.1725281439114; Mon, 02 Sep 2024
 05:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtUuYXSq8g2Mphuq@den-build> <87r0a27blv.ffs@tglx>
 <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com> <877cbu7596.ffs@tglx>
In-Reply-To: <877cbu7596.ffs@tglx>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 2 Sep 2024 20:50:27 +0800
Message-ID: <CAJNi4rPooS82fB+6FditywXTga00JbGoFM6MR8P7U3s7mdbJCg@mail.gmail.com>
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	torvalds@linux-foundation.org, richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Sep 2, 2024 at 5:51=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Richard!
>
> On Mon, Sep 02 2024 at 16:42, richard clark wrote:
> > On Mon, Sep 2, 2024 at 3:34=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> 1) insmod()
> >>      irq_create_fwspec_mapping(fwspec)
> >>        irq_domain_translate(fwspec, ... &type); <- Sets type to the FW=
 value
> >>
> >>        virq =3D irq_find_mapping(domain, hwirq);
> >>        if (virq) {
> >>          // Path not taken
> >>        }
> >>
> >>        // Map interrupt
> >>        ...
> >>
> >>        irqd_set_trigger_type(..., type);
> >>
> >> 2) rmmod()
> >>      tears down mapping
> >>
> > This just tears down the action allocated and installed by
> > request_irq(...), but does not teardown the irq's node inserted in the
> > revmap_tree.
>
> So what creates the mapping? If the driver creates it then why doesn't
> it unmap it when it exits?
>
Kernel allocates an irq and creates the mapping during its
initialization when parsing the device's interrupt firmware, not the
driver does that.
>
> >> 3) insmod()
> >>
> >>       Should be exactly the same as #1 because the previous mapping wa=
s
> >>       torn down by rmmod()
> >>
> > Not the same exactly, the {irq, irq_data} will still be in the
> > revmap_tree, so it will enter another path in this case:
>
> That's exactly the question. Why does the mapping persist?
>
AFAICT the kernel creates the mapping to bind the allocated irq to its
firmware node, thus this {key, value} pair can be used persistently in
the future while not re-iterate the cycle again. irq and the mapping
can be regarded as the part of the kernel, not the scope of the
driver.
>
> >> So how exactly does that happen what you describe?
> >>
> > The logic is if the trigger type specified by request_irq(...) is not
> > consistent with the firmware one, the request_irq will override the
> > FW. We need to keep this logic the same as when we insmod the same
> > kmod next time -- override the FW's too instead of returning a
> > mismatch type error.
>
> I can see how that can happen, but what's missing is the information why
> this mapping persists and why it's tried to be set up again.
>
As I mentioned, it doesn't try to set up again. It will just lookup
the mapping from the tree for the persistent reason when driver try to
request the irq...

Thanks,
>
> Thanks,
>
>         tglx

