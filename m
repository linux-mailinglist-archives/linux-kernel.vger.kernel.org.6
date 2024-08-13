Return-Path: <linux-kernel+bounces-284123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19894FD34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE0F1C227A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9B23774;
	Tue, 13 Aug 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="jjFMs/bx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C522F1E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723526824; cv=pass; b=h9lYL15isjJcte7wSd2PEBuwauQhCRU4qHHciuGx5u20fNutMuopJDbVnj8A7FTxVFbeuNh5zKWOEGe1laMqChtDk5XmPJXd/AItlbdYQRfn7WYm8FwewqEm9CnTBMXh6SXnNwqvn6anTT4kBzUdDBWziiZsw+PboYhs3M9nMOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723526824; c=relaxed/simple;
	bh=YGaQe4KKRVC6dpf0alIK5tnIeEA50ZEG3pF4uvCiZY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5qcE4rXiw6RG9XAWHvSnVcrXunJMH0aaOfOAzmIqbI6OcRzprv3VCF3WDhDPFrFNRIZMNfbFKMabEDvFnMtZgy08rktKDfr2qa6EG1GvxfUD78IDE1pxp92okvOtUIXgmNNcvUgEzosrIcEe9TSRymCWHOq3Zx5lespsi18vGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=jjFMs/bx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: helen.koike@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723526817; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TBuwrM0saWZPCqAeR7bOvoAJihweig4uRIiqtFMaQcMknDrOMpCmIJBPkfhWBb/NtamDcFA8H6wk0yg25GPIz0U5CcYN4EjNzL2XDDoASBI08ZiWaPD2FZoNbGzlIenX7tTJKVFv/IITMggF84Alj36eJF3GXH09XoZhyv/y/Qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723526817; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rFEqiFqQaYU8I5HFp17toWrFMIexxBuRoUMGPBJIvrU=; 
	b=RZon6LfWR33o09NNUuZKztLslmFEcfZXGPoJnA8mM6S6yPlNGkkEDhgoPCOjnnaTatTZe701t81EGZto56SXVtPGXhxJU0gPrdI8vO+TQxSDKmGR/d1DtHGR8gtqPZFPzpgfaokLoXWa99tgejNegP+zzD5MPTcAjbW2XPT+SZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723526817;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rFEqiFqQaYU8I5HFp17toWrFMIexxBuRoUMGPBJIvrU=;
	b=jjFMs/bxjBn8qsxZGBSFk4th52rWaa9lem6b4lmP4A1R4oxUVXvI1haG4Yaf/unq
	raBvCNEwqdVerna8SQhI0uU5WCUre4GDKad+iXrNfDUTFhKHrE+rgPA4rSGaMUuuaiE
	GenIhZ1JU+psHFBkMp6+fEny4YMVRbmnFBh0rryE=
Received: by mx.zohomail.com with SMTPS id 1723526814512715.4805688385032;
	Mon, 12 Aug 2024 22:26:54 -0700 (PDT)
Message-ID: <0a3db7dc-4533-4111-bec9-35cc68e35d83@collabora.com>
Date: Tue, 13 Aug 2024 10:56:48 +0530
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
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <191483d05a3.129198f97500814.8001634600010504645@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Helen,

On 13/08/24 01:47, Helen Mae Koike Fornazier wrote:
> 
> Hi Vignesh,
> 
> Thanks for your patch.
> 
> 
> ---- On Mon, 12 Aug 2024 08:20:28 -0300 Vignesh Raman  wrote ---
> 
>   > We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-ci.
>   > This will output warnings when kernel locking errors are encountered
>   > and will continue executing tests. To detect if lockdep has been
>   > triggered, check the debug_locks value in /proc/lockdep_stats after
>   > the tests have run. When debug_locks is 0, it indicates that lockdep
>   > has detected issues and turned itself off. So check this value and
>   > exit with an error if lockdep is detected.
> 
> Should we exit with an error? Or with a warning? (GitLab-CI supports that).
> Well, I guess it is serious enough.

I think we can exit with an error since we check the status at the end 
of the tests.

> 
> Should we also track on the xfail folder? So we can annotate those errors as well?

Do you mean reporting this error in expectation files?

> Did you have an entire pipeline with this? To see if everything is still green?

Yes. https://gitlab.freedesktop.org/vigneshraman/linux/-/jobs/62177711

This is a test branch in which I reverted a fix for the lockdep issue.
We see 'WARNING: bad unlock balance detected!' in logs and pipeline is 
still green.

Regards,
Vignesh

> 
> Helen
> 
>   >
>   > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com>
>   > ---
>   >
>   > v1:
>   >  - Pipeline link to show lockdep_stats before and after tests,
>   >  https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1246721
>   >
>   > ---
>   >  drivers/gpu/drm/ci/igt_runner.sh | 11 +++++++++++
>   >  1 file changed, 11 insertions(+)
>   >
>   > diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
>   > index f38836ec837c..d2c043cd8c6a 100755
>   > --- a/drivers/gpu/drm/ci/igt_runner.sh
>   > +++ b/drivers/gpu/drm/ci/igt_runner.sh
>   > @@ -85,6 +85,17 @@ deqp-runner junit \
>   >  --limit 50 \
>   >  --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.freedesktop.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testcase}}.xml"
>   >
>   > +# Check if /proc/lockdep_stats exists
>   > +if [ -f /proc/lockdep_stats ]; then
>   > +    # If debug_locks is 0, it indicates lockdep is detected and it turns itself off.
>   > +    debug_locks=$(grep 'debug_locks:' /proc/lockdep_stats | awk '{print $2}')
>   > +    if [ "$debug_locks" -eq 0 ]; then
>   > +        echo "LOCKDEP issue detected. Please check dmesg logs for more information."
>   > +        cat /proc/lockdep_stats
>   > +        ret=1
>   > +    fi
>   > +fi
>   > +
>   >  # Store the results also in the simpler format used by the runner in ChromeOS CI
>   >  #sed -r 's/(dmesg-warn|pass)/success/g' /results/results.txt > /results/results_simple.txt
>   >
>   > --
>   > 2.43.0
>   >
>   >

