Return-Path: <linux-kernel+bounces-286205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB59517E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA48B21DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B69165EF3;
	Wed, 14 Aug 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="C4eYxQCb"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CA12C484
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628552; cv=pass; b=TDRsNL7IMHRr6ZXd7/JH7CbU3E9Bi1EKyA1NTEto2kfUY9g0IwYH0mejfC8ycG2RIzNgeZf/SVklELlKWe/TndZf6YmUupra9B/qCdqXMi3G4ZanUZYkJa105muKKhNmubT0xiNNk23MQA3C03wgojm6wunMowqt3se3xr7WUxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628552; c=relaxed/simple;
	bh=L6MXgYiwTPXtSCnb2Bpqp0fFrX64gXmNzK0UApHAmP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa5+ijPR8xV+CVnxsXWM84SEBVGC5olYdwZtaq8/Eqk3cUZEPgkV5MdP6monJwV8TEwmSGUD8ITjgcXO+CfOAN7+BimECtJhWJ+EaBrejH7YCuC+gA5xUWjK4huHUww+5vGAWHPqtQtQ3SfH00oaqVkaaOYTtX+Qu4ujc5pcGmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=C4eYxQCb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: helen.koike@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723628545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D1rJcxESAtBdt6i8nWdAh0w8/sRVVAlSEhDWMMJzPZOSL8C+as9cABEP9xhYwv7zkKr5kul+Xn2Tpk7uh4uDfJfFDr+yt+Pb8BRnGj5B/EISKXomQ90+bx/NgT8guQpex32BA025GqLwk74BOzi7R5yQcWn7Ov6MQjE0uUJbZDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723628545; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w1lj4Ku49BfHwbSHApbEdIO8jbS21dyuVJ1bMcM9HxE=; 
	b=DGtgCWGHXFKXPw2X9LCjuPpe21UFvqthtsZwE2p2/FUF3hQsxeP0Ry/o+PylaoavrVwNAK5yosfMhM54F9Lr+A7ZQDJ3aXNGHlYlsnTy3uKswpaO4ZqhWTO9RgloDBFRGVKS7Eg5cDaotQYJDHkQ0601f2KyDPHWuOBNaHytEfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723628545;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=w1lj4Ku49BfHwbSHApbEdIO8jbS21dyuVJ1bMcM9HxE=;
	b=C4eYxQCbm66rnLSCnBPdTOPY6pf/WYLAOEMXXFTgxAEFgCMqjqCn4J3zAqjrW1qb
	DkCEC9Z8qizHs7FuadnBBO7oaiZLZi/d9BVHK03ga3YrJK1sE9SBV04UnKYOSH4UbIE
	TZAynknCHDHTWDimepJZCPJjFoq3cC3hEKS9Bcwg=
Received: by mx.zohomail.com with SMTPS id 1723628542404965.8729371058215;
	Wed, 14 Aug 2024 02:42:22 -0700 (PDT)
Message-ID: <42753719-9619-45f1-b76a-8ff8d19cec22@collabora.com>
Date: Wed, 14 Aug 2024 15:12:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: enable lockdep detection
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 daniels <daniels@collabora.com>, airlied <airlied@gmail.com>,
 daniel <daniel@ffwll.ch>, robdclark <robdclark@gmail.com>,
 "guilherme.gallo" <guilherme.gallo@collabora.com>,
 "sergi.blanch.torne" <sergi.blanch.torne@collabora.com>,
 "deborah.brouwer" <deborah.brouwer@collabora.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20240812112030.81774-1-vignesh.raman@collabora.com>
 <191483d05a3.129198f97500814.8001634600010504645@collabora.com>
 <0a3db7dc-4533-4111-bec9-35cc68e35d83@collabora.com>
 <1914d612d8e.f2d5101b916106.3138016556910118397@collabora.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <1914d612d8e.f2d5101b916106.3138016556910118397@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Helen,

On 14/08/24 01:44, Helen Mae Koike Fornazier wrote:
> 
> 
> 
> 
> ---- On Tue, 13 Aug 2024 02:26:48 -0300 Vignesh Raman  wrote ---
> 
>   > Hi Helen,
>   >
>   > On 13/08/24 01:47, Helen Mae Koike Fornazier wrote:
>   > >
>   > > Hi Vignesh,
>   > >
>   > > Thanks for your patch.
>   > >
>   > >
>   > > ---- On Mon, 12 Aug 2024 08:20:28 -0300 Vignesh Raman  wrote ---
>   > >
>   > >   > We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
>   > >   > This will output warnings when kernel locking errors are encountered
>   > >   > and will continue executing tests. To detect if lockdep has been
>   > >   > triggered, check the debug_locks value in /proc/lockdep_stats after
>   > >   > the tests have run. When debug_locks is 0, it indicates that lockdep
>   > >   > has detected issues and turned itself off. So check this value and
>   > >   > exit with an error if lockdep is detected.
>   > >
>   > > Should we exit with an error? Or with a warning? (GitLab-CI supports that).
>   > > Well, I guess it is serious enough.
>   >
>   > I think we can exit with an error since we check the status at the end
>   > of the tests.
> 
> I mean, we can exit with a specific error and configure this specific error in gitlab-ci to be a warning,
> so the job will be yellow and not red.
> 
> But maybe the lockdep issue should be a strong error.

Yes agree. We can exit with an error for lockdep issue instead of a warning.

> 
>   >
>   > >
>   > > Should we also track on the xfail folder? So we can annotate those errors as well?
>   >
>   > Do you mean reporting this error in expectation files?
> 
> I wonder if there will be cases were we are getting this error and we should ignore it, so in the code
> we should check the xfail files to see if we should exit with an error or ignore it.
> 
> For instance, if we have a case where we are having this error, and it is flaky, we might want to add it
> to the flakes file list.
> 
> Maybe this is not the case, I'm just wondering.


The tests are passing but log shows lockdep warning 
(https://gitlab.freedesktop.org/vigneshraman/linux/-/jobs/62177711).

Moreover if the lockdep warning is emitted, lockdep will not continue to 
run and there is no need to check this warning for each tests.
So added the check at the end of the tests.

> 
> 
>   >
>   > > Did you have an entire pipeline with this? To see if everything is still green?
>   >
>   > Yes. https://gitlab.freedesktop.org/vigneshraman/linux/-/jobs/62177711
>   >
>   > This is a test branch in which I reverted a fix for the lockdep issue.
>   > We see 'WARNING: bad unlock balance detected!' in logs and pipeline is
>   > still green.
> 
> But with your patch, it would red right?

Yes it would fail and the pipeline will be red.

> With the current patch, is the pipeline still all green?

With this current patch, it will fail.
Pipeline link to show lockdep_stats before and after tests,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1246721

Regards,
Vignesh

> 
> Regards,
> Helen
> 
>   >
>   > Regards,
>   > Vignesh
>   >
>   > >
>   > > Helen
>   > >
>   > >   >
>   > >   > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com>
>   > >   > ---
>   > >   >
>   > >   > v1:
>   > >   >  - Pipeline link to show lockdep_stats before and after tests,
>   > >   > https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1246721
>   > >   >
>   > >   > ---
>   > >   >  drivers/gpu/drm/ci/igt_runner.sh | 11 +++++++++++
>   > >   >  1 file changed, 11 insertions(+)
>   > >   >
>   > >   > diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
>   > >   > index f38836ec837c..d2c043cd8c6a 100755
>   > >   > --- a/drivers/gpu/drm/ci/igt_runner.sh
>   > >   > +++ b/drivers/gpu/drm/ci/igt_runner.sh
>   > >   > @@ -85,6 +85,17 @@ deqp-runner junit \
>   > >   >  --limit 50 \
>   > >   >  --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.freedesktop.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testcase}}.xml"
>   > >   >
>   > >   > +# Check if /proc/lockdep_stats exists
>   > >   > +if [ -f /proc/lockdep_stats ]; then
>   > >   > +    # If debug_locks is 0, it indicates lockdep is detected and it turns itself off.
>   > >   > +    debug_locks=$(grep 'debug_locks:' /proc/lockdep_stats | awk '{print $2}')
>   > >   > +    if [ "$debug_locks" -eq 0 ]; then
>   > >   > +        echo "LOCKDEP issue detected. Please check dmesg logs for more information."
>   > >   > +        cat /proc/lockdep_stats
>   > >   > +        ret=1
>   > >   > +    fi
>   > >   > +fi
>   > >   > +
>   > >   >  # Store the results also in the simpler format used by the runner in ChromeOS CI
>   > >   >  #sed -r 's/(dmesg-warn|pass)/success/g' /results/results.txt > /results/results_simple.txt
>   > >   >
>   > >   > --
>   > >   > 2.43.0
>   > >   >
>   > >   >
>   >

