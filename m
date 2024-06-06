Return-Path: <linux-kernel+bounces-204877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D188FF497
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36710B2A0B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2D19939C;
	Thu,  6 Jun 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WTb7nrrf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FA1991D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698291; cv=none; b=Ei2JWEcbUroCF3VEf0Yj6fR+Ug4pjwoDeZtqR9+KliGh0ip1LMGzgqOWzi1zFGD88Fz2hA1wLegqB18H8SWAoT20dzDia9z/ArWkuIqLTDbdBWDQEJE2hY8+H2rdpkpEGnA0sDkoNMjbaRMVaaWrYOG54nUMJIOTbPeauf2OKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698291; c=relaxed/simple;
	bh=nFNwZjwWrvyOyNkS5EL5RDmYDz9n7HpbU1l2B+KUFYE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MeNQkTSa8n5/WOpVHMzJMn2KrD2/ITlx9OpMaInNiP4h012m7L5NICyMzGBW8iTFCiGr8podPwuYY5tXWNN89Uvy4PqGIKyNun8+/71YRnMUmVBRTFbTe1Hc+oITo+o/EKSErHq1HtffHXVU+rs+1/k79qn+rQTnWQ8/40sN9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WTb7nrrf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717698281;
	bh=nFNwZjwWrvyOyNkS5EL5RDmYDz9n7HpbU1l2B+KUFYE=;
	h=Date:To:Cc:From:Subject:From;
	b=WTb7nrrfCwV39z+ie8e6bJ+jHuahgNpiGfFJiABJr4+k7uCTqsju2A4GBf9J686TS
	 0J88eez0lCP8rGdK6tjumsFlEIaQvXUH/Tn7C92Ja+oI455n7/LNP9RlxrvMRdFqJW
	 UmCosevWz8dZ+PImqOgeNnwGRCR/LaQ2D4MJYBtpHov81FBsPbh6CGvY6BBXQak4S+
	 myHeGSyuSc7BuJTLL6c+YVLtJINNLpaIDtCI4klUQhJJmBJX3YoUSrN893fwiFZmff
	 ZUssZNl9Hf2FSOjzRsrsVidnrhkTI4fdCCV8nI3OIxv5vPqQMgc0Nnb9QotfGw+SAt
	 VOdrrR/oGtuWg==
Received: from [100.118.151.62] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: padovan)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B2CA37820A9;
	Thu,  6 Jun 2024 18:24:40 +0000 (UTC)
Message-ID: <5b603b8f-c9b2-4148-7212-dd69a3fdf506@collabora.com>
Date: Thu, 6 Jun 2024 15:24:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Cc: "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Gustavo Padovan <gus@collabora.com>
Subject: KernelCI switch to new testing architecture - plan
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

As most of you know, the KernelCI community developed a new testing 
architecture.
It is now time to move over to it. In this message, we want to share 
some details about
the upcoming movements, especially about the shutdown of the existing 
legacy system.

In our latest blog post[1], we shared an update about what's coming. 
 From a strategic
point of view, not much has changed since that blog post. We made 
progress on the
implementations, making the systems more stable, adding more tests and 
labs and
refining the data connection with KCIDB.

As shared at that time, the primary focus in the new testing 
architecture is on quality
rather than quantity. We want high quality test results that will reduce 
the community's
workload, and not waste their time with low-quality test results. **As a 
direct
consequence of our focus on quality, we will not port all tests from 
legacy KernelCI
to the new system**. Reach out to us at kernelci@lists.linux.dev, if you 
want to see
specific tests ported and we will give you instructions and support on 
how to do it.

Current status:
* ready to receive new trees and tests
* moving existing labs over
* developing the new Web Dashboard

The new Web Dashboard should be ready in the coming months for basic 
visualization.
In the meantime, we have the grafana instance to build boards to 
visualize test results
and also some interim tooling that pulls the data from the API and 
generates reports.
If you want to bring your tree and tests over and use our tooling to 
analyze the results,
we can onboard you while also benefiting from your feedback to evolve 
our regression
tracking intelligence.

We will share more information about the transition as the work evolves 
in the
coming months. Don't worry!

The target is to shutdown the legacy system around the end of August[2]. 
Some labs
will probably disconnect themselves from legacy KernelCI before that. We 
can not delay
the shutdown date much as the amount of cloud resources and engineering 
is a high
toll to the project.

**If you are depending on legacy KernelCI, please speak up, so we can 
help you move
your stuff over to the new system.**

To be clear, the KernelCI project will not maintain 100% compatibility 
with what was
provided by its legacy system. As we create a better future for 
KernelCI, some hard decisions
had to be taken; not porting all tests and usecases was one of them.

As we leave our legacy behind, a vibrant community has been gathering 
around KernelCI in
the past few months, corroborating the new strategic directions we are 
putting in place for
the project. Bear with us during this transition and the future will be 
brighter!

We are happy to hear thoughts and questions from everyone about the 
transition. We are
probably forgetting some important details in this message.

Thank you for your continued support and your patience as the KernelCI 
project goes
through its biggest change since its inception.

Best Regards,

- Gus

[1] https://kernelci.org/blog/posts/2024/strategic-updates/
[2] https://github.com/kernelci/kernelci-project/issues/337

-- 
Gustavo Padovan
Kernel Lead

Collabora Ltd.
Platinum Building, St John's Innovation Park
Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


