Return-Path: <linux-kernel+bounces-218504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49090C0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CEC1F22962
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C57484;
	Tue, 18 Jun 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+2rj0fG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC84C98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672717; cv=none; b=UvM7zYyly8KkVIhOMKT6Rm3syf+dPEHo/CEnZQv2vrPF2t81qxMuo3MKul7teg4ldgJUCv8qhuBGvDWmekfnhJVXMZ8iaYOMqxk91VsYqVJZo4OoQqmaAbnSc1tMXe1K1wKdzpXJ7iLmDKGyy44+bcjDVvH+dwx4ePtuSInG3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672717; c=relaxed/simple;
	bh=SAkpgrEbrLfBSD9HlN2+JeG8+6Qho66P/tm5pyVKlbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUdn8bofrQB678SuGoeS8pqOlBzDlSK7bTffjjHX7DyS6OJd0gJuJr6/jTv3kbvS+5LtqO2iGt1fb6HfKcxGxPyAVwWZJDKOdZWlFjpfIacKWTh85EF7T1mPlZwlGxyH/7TaUtFhi8R2soIzJtMCTot26MdGaQ9hYoZigEU6rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+2rj0fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0654C2BD10;
	Tue, 18 Jun 2024 01:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672716;
	bh=SAkpgrEbrLfBSD9HlN2+JeG8+6Qho66P/tm5pyVKlbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+2rj0fG5LFyr0zi0IQWX3YKmUR545oouD7b3nnRp+VOK6HvTp9rlyg9LDu70bmcI
	 gZufrn/4njTDoVnLIJNFTlsTRhP2QVgXUlIctzHMK5JaDlWNbMhGp7/YEXfa17s9Dd
	 H7bK31MQG5uoUfcgnfy5XbrpKY1TCEHrDj8+GiZIhpK59rab/STKqWgjb6WsfvPrDj
	 POO4Juq2w+dmZX3DOEo3hcTeBwdpPkuATJCGBGKUv1n0BR2UVt5aMJQupLVl3LC8pm
	 PWoP8rHfPM9vjSn1eXWSAlQ9JwDgfHv+zZ6BwaYI5eS51xlj7DsgbywkIOdwxzMrmb
	 chlvze7jXRQCQ==
Message-ID: <ab63f640-aa26-4c2f-9020-09953fd8d39d@kernel.org>
Date: Tue, 18 Jun 2024 09:05:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] f2fs-tools: use atoll replace atoi to avoid data
 truncate
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com
References: <20240612071749.348843-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240612071749.348843-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/12 15:17, Xiuhong Wang wrote:
> If input exceeds int range, data will be truncated, such as lseek:
> unisoc:/data # ./f2fs_io lseek set 3221225000 file
> returned offset=2147483647
> The offset is truncated.
> 
> After patch:
> unisoc:/data # ./f2fs_io lseek set 3221225000 file
> returned offset=3221225000
> 
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

