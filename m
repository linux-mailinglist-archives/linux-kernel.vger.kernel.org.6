Return-Path: <linux-kernel+bounces-311531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB29968A25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A121F2384F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F41A2646;
	Mon,  2 Sep 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rn/YDrpE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3psHJuxL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D881A2621
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287978; cv=none; b=AooqcOvOAMaLdlsXAIBSJ5cITHXel258nQsoAsuHWSOHVU63kFosoHmKXPkQzxVd80fO6J+NUQ6VfpZCpzsiYBsQQJIbitJ+TwulRH7hS/HSpOZGRoBEDLuppFVhsZTU4Ipo6VSMHILkPn7b3VQNbT8jXbulY4wHF8U5Ufsp8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287978; c=relaxed/simple;
	bh=RQwMJ54pObplkkG/Q6UXo8jIzFKh9Y1aSOxOpVNnwTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wk69chu8NwOwRZzxXS/eNSm3bmCv0fHUmJ7K97zK7wI/ureSA/BwyYEKlAM/QWFl5RDW6UanKkB9xofbPjA8Dd+rc2lrGsrIxQ0YzHdXjcW9PtXZ+nkL2I5LG0GaSOBgN7innJGi8H0ODjE4mAG7SajynHLq7O8kkXe4LrG6nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rn/YDrpE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3psHJuxL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725287973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysn9klxB1AuJGKxyFma9j9cJpHGmLYYCryX+zpCeJjo=;
	b=rn/YDrpEf3aCWr5EKE9j+Z7JmquNw7H4Mo+BJIwwZ62YF8r2tPVN1lFCN4veKPn58MQazD
	YbeCcVVogyIsxDqelcbK+eMz8ZV65oqZa7i8uc1MbhAMDyM8RbAE9IK6znNqUrfom9tk/F
	c8MIjhP/B38vmxP/0VV8qQZXc2TNtgGViKLcqJVvPX0Zfny9NG5IPlcECtslsKpLE4k0A5
	3oErctjBm7zJP1E6kBfNB4ZmZ50iTd3soNHfqk4YJKSLF9S9Jvg3rbDf8wodxot987/Rtb
	izXkIuMPu8t4o8P+9NSkwQ8VwE5VEmqmSSmMQYb3O1EtLJ5mVCJ8gHDvMs6osA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725287973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysn9klxB1AuJGKxyFma9j9cJpHGmLYYCryX+zpCeJjo=;
	b=3psHJuxLZde1dVw3bPGBTUUl/sPqIoIjC4s2RIqYe65HbnMBC+TuXkqWlfvohbc9HIED7k
	gzch2pz+qznvzEDw==
To: richard clark <richard.xnu.clark@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org, richard clark <richard.xnu.clark@gmail.com>
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
In-Reply-To: <CAJNi4rPooS82fB+6FditywXTga00JbGoFM6MR8P7U3s7mdbJCg@mail.gmail.com>
References: <ZtUuYXSq8g2Mphuq@den-build> <87r0a27blv.ffs@tglx>
 <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
 <877cbu7596.ffs@tglx>
 <CAJNi4rPooS82fB+6FditywXTga00JbGoFM6MR8P7U3s7mdbJCg@mail.gmail.com>
Date: Mon, 02 Sep 2024 16:39:33 +0200
Message-ID: <87y14a5dcq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard!

On Mon, Sep 02 2024 at 20:50, richard clark wrote:
> On Mon, Sep 2, 2024 at 5:51=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> >> 2) rmmod()
>> >>      tears down mapping
>> >>
>> > This just tears down the action allocated and installed by
>> > request_irq(...), but does not teardown the irq's node inserted in the
>> > revmap_tree.
>>
>> So what creates the mapping? If the driver creates it then why doesn't
>> it unmap it when it exits?
>>
> Kernel allocates an irq and creates the mapping during its
> initialization when parsing the device's interrupt firmware, not the
> driver does that.

So the mapping and the interrupt allocation persist even if nothing uses
them. What a waste.

>> > The logic is if the trigger type specified by request_irq(...) is not
>> > consistent with the firmware one, the request_irq will override the
>> > FW. We need to keep this logic the same as when we insmod the same
>> > kmod next time -- override the FW's too instead of returning a
>> > mismatch type error.
>>
>> I can see how that can happen, but what's missing is the information why
>> this mapping persists and why it's tried to be set up again.
>>
> As I mentioned, it doesn't try to set up again. It will just lookup
> the mapping from the tree for the persistent reason when driver try to
> request the irq...

Fair enough. Though the logic in that map code is convoluted as hell and
making it more convoluted does not really make it better.

So let's look at how this works (or not):

1)
   map()
   allocate_irq();
   set_trigger_type(FW);

2)
   request_irq(type =3D DRV);
   set_trigger_type(DRV);

3)
   free_irq();
   // type is not reset to FW

4)
   map()
     irq_trigger_type() !=3D NONE && !=3D FW
        -> fail

This results in a pile of questions:

  Why does #2 override the firmware, if the firmware defines a trigger
  type !=3D NONE?

  Isn't the whole point of firmware defining the type that the driver
  does not need to care?

  If the firmware cannot does not know what the right thing is then it
  should say so by using type NONE and the type is using the hardware
  or interrupt driver default.

That aside. What you are trying to do only works when #2 and #4 are
coming from the exactly same context.

What it does not catch is when the interrupt line is shared and there
are two drivers where the first one fiddles with type on request_irq()
and the second one relies on the firmware to do the right thing.

Same problem if you unload the driver and remove the type from
request_irq() flags because you figured out that this was bogus. Then
you end up with the old setting when you load the recompiled driver
again.

That's all inconsistent. The proper solution would be to restore the
firmware setting in free_irq() when the last action goes away.

The question is whether it's worth the trouble. If not then we can just
make all of this simple, trivial and incomplete instead of making it
more complex and differently incomplete.

Thanks,

        tglx
---
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -895,32 +895,14 @@ unsigned int irq_create_fwspec_mapping(s
 	 */
 	virq =3D irq_find_mapping(domain, hwirq);
 	if (virq) {
-		/*
-		 * If the trigger type is not specified or matches the
-		 * current trigger type then we are done so return the
-		 * interrupt number.
-		 */
-		if (type =3D=3D IRQ_TYPE_NONE || type =3D=3D irq_get_trigger_type(virq))
-			goto out;
-
-		/*
-		 * If the trigger type has not been set yet, then set
-		 * it now and return the interrupt number.
-		 */
-		if (irq_get_trigger_type(virq) =3D=3D IRQ_TYPE_NONE) {
+		/* Preserve the trigger type set by request_irq() */
+		if (type !=3D IRQ_TYPE_NONE && irq_get_trigger_type(virq) =3D=3D IRQ_TYP=
E_NONE) {
 			irq_data =3D irq_get_irq_data(virq);
-			if (!irq_data) {
+			if (irq_data)
+				irqd_set_trigger_type(irq_data, type);
+			else
 				virq =3D 0;
-				goto out;
-			}
-
-			irqd_set_trigger_type(irq_data, type);
-			goto out;
 		}
-
-		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
-			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		virq =3D 0;
 		goto out;
 	}
=20

=20=20=20

