Return-Path: <linux-kernel+bounces-250638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38492FA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43DEDB2319F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23116F260;
	Fri, 12 Jul 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2tq6xZsJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FE1662FE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787762; cv=none; b=CGi7fpWHN2CwxzZ4S3SZIQ8LjGyuar+9nPmy4IC5JcgyqSB+83vFp9wWZs6jGrfMQVjfkhyCeznmUcyxULlvHGfapQ+NzXUDfFvKswJVbBQqxZvAO3Eg7tI1JQTGEwIx/4sjrP1aJx39B8McaWJg49TQmPnG5j+f2tqwvrqn13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787762; c=relaxed/simple;
	bh=tnPP2l5eO7teiE76XxRKobWJamT+z1EWUXt+zDbhjCc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H4yIwddBN+OLgFd9xDGvKwh6efeDYdatgFY5rI0FfsNpUVLLK9RfdCEkhfmQoAQ+VBhL59pAlKCeFzrqJFjBiJ9DjxEMMSht4ggdcxi9Y6DEcFDWrw1si2/5jUFVqj4sBpc2EmMV1awWSHJJ94lM2x6pZT8cwtoPbd+igJpJ7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2tq6xZsJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720787757;
	bh=tnPP2l5eO7teiE76XxRKobWJamT+z1EWUXt+zDbhjCc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=2tq6xZsJ/1XLchHKiiMWSB5wAd2Rxmls2p/bYznO71y5njk1L7WxTL9u98agk5y8E
	 CPxwwr5gzB5J8bIkTj9i/PpKinfv+oYXwVOmnkt9AYyow9oVuMzFon2/hDVWOt9CrQ
	 K5G2xvEI5t2yB/jEfjDB3L0SfkKOrmfX7qEyW64UM2stBZfe8bbiZYTpSSsTa6SgBO
	 y+SF0t+upCpeCYvJvOFrnhZYIQPOu95U3HPK3ofxHv41hPf+Ey3dVU3mdao636Nx0y
	 de9gZkezwETFSMDDdCy3kX/mn+0QrJvmBUz0TLCyz+2RwmSdnOP9S/prmLDCHN//n2
	 BGsdUpRIsps2Q==
Received: from [100.118.151.62] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: padovan)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE13B3781480;
	Fri, 12 Jul 2024 12:35:56 +0000 (UTC)
Message-ID: <c9c9ce5c-a571-48db-94e8-396d96e4f6ce@collabora.com>
Date: Fri, 12 Jul 2024 09:35:48 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KernelCI switch to new testing architecture - plan
From: Gustavo Padovan <gus@collabora.com>
To: "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Cc: "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5b603b8f-c9b2-4148-7212-dd69a3fdf506@collabora.com>
Content-Language: en-US
In-Reply-To: <5b603b8f-c9b2-4148-7212-dd69a3fdf506@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

It is for another update on the switch to the new testing architecture. 
As already highlighted in the previous
  email,we keep enabling new trees and tests, and enabling labs in the 
system. The new Web Dashboard is
  also under fast development, through a specialized supplier company 
hired by the KernelCI Foundation
  and a first beta version is expected by LPC.

We are also going through a major overhaul of the KernelCI project 
documentation to highlight the
  different ways different users can engage with KernelCI. For example: 
upstream kernel maintainers
  are interested in adding tests, Lab owners are interested in adding 
the labs, CI systems across the
  Linux community are interested in sending their data to KCIDB. It will 
take some time for all
  documentation changes to land, so hold tight and send an email to us 
at kernelci@lists.linux.dev
  if you have any questions.

As for shutting down our legacy system, in the coming days both the 
BayLibre and Collabora
  will be disconnected from the legacy system, removing a significant 
amount of devices. The
  message is pretty clear: no one should be using legacy KernelCI anymore.

**If you are depending on legacy KernelCI, please speak up, so we can 
help you move your
  stuff over to the new system.**

## What is legacy KernelCI?

It is the old Jenkins based system with results showing up at 
linux.kernelci.org - if you are still
  using it you are using legacy KernelCI


## Where is the dashboard for the new KernelCI?

As highlighted in the beginning of this message, the new dashboard is 
under fast development
  after a good phase of UX research. In the meantime, we created a 
grafana dashboard that we
  will deploy in the coming days and share the link here.

Let me know any other questions you have. We'd be happy to answer them.

Best regards,

- Gus

On 6/6/24 3:24 PM, Gustavo Padovan wrote:
> Hello everyone,
>
> As most of you know, the KernelCI community developed a new testing 
> architecture.
> It is now time to move over to it. In this message, we want to share 
> some details about
> the upcoming movements, especially about the shutdown of the existing 
> legacy system.
>
> In our latest blog post[1], we shared an update about what's coming. 
> From a strategic
> point of view, not much has changed since that blog post. We made 
> progress on the
> implementations, making the systems more stable, adding more tests and 
> labs and
> refining the data connection with KCIDB.
>
> As shared at that time, the primary focus in the new testing 
> architecture is on quality
> rather than quantity. We want high quality test results that will 
> reduce the community's
> workload, and not waste their time with low-quality test results. **As 
> a direct
> consequence of our focus on quality, we will not port all tests from 
> legacy KernelCI
> to the new system**. Reach out to us at kernelci@lists.linux.dev, if 
> you want to see
> specific tests ported and we will give you instructions and support on 
> how to do it.
>
> Current status:
> * ready to receive new trees and tests
> * moving existing labs over
> * developing the new Web Dashboard
>
> The new Web Dashboard should be ready in the coming months for basic 
> visualization.
> In the meantime, we have the grafana instance to build boards to 
> visualize test results
> and also some interim tooling that pulls the data from the API and 
> generates reports.
> If you want to bring your tree and tests over and use our tooling to 
> analyze the results,
> we can onboard you while also benefiting from your feedback to evolve 
> our regression
> tracking intelligence.
>
> We will share more information about the transition as the work 
> evolves in the
> coming months. Don't worry!
>
> The target is to shutdown the legacy system around the end of 
> August[2]. Some labs
> will probably disconnect themselves from legacy KernelCI before that. 
> We can not delay
> the shutdown date much as the amount of cloud resources and 
> engineering is a high
> toll to the project.
>
> **If you are depending on legacy KernelCI, please speak up, so we can 
> help you move
> your stuff over to the new system.**
>
> To be clear, the KernelCI project will not maintain 100% compatibility 
> with what was
> provided by its legacy system. As we create a better future for 
> KernelCI, some hard decisions
> had to be taken; not porting all tests and usecases was one of them.
>
> As we leave our legacy behind, a vibrant community has been gathering 
> around KernelCI in
> the past few months, corroborating the new strategic directions we are 
> putting in place for
> the project. Bear with us during this transition and the future will 
> be brighter!
>
> We are happy to hear thoughts and questions from everyone about the 
> transition. We are
> probably forgetting some important details in this message.
>
> Thank you for your continued support and your patience as the KernelCI 
> project goes
> through its biggest change since its inception.
>
> Best Regards,
>
> - Gus
>
> [1] https://kernelci.org/blog/posts/2024/strategic-updates/
> [2] https://github.com/kernelci/kernelci-project/issues/337
>

-- 
Gustavo Padovan
Kernel Lead

Collabora Ltd.
Platinum Building, St John's Innovation Park
Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


