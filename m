Return-Path: <linux-kernel+bounces-301561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3F95F28B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1531C21B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FE17C99B;
	Mon, 26 Aug 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="naeHyF9I"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAB1E519
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678030; cv=none; b=d/ogCeXWsKlS6worpjOCq1TcJX6F/J33of+2c09VLuMdDeFK3sIxvEwyp5tI0uUC1Lli/HzE2QYhbg5Nb9mNLOTWEgwI3tpYsYSYxB3ItBl+1bdutqoeTmRENim5pijOPnIivz70PDFz/vzXwNYGn77FrroG5+hB7Auuc24A64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678030; c=relaxed/simple;
	bh=AuD8HiuxBBIo8qVPg1yzq9hZ/C1nf3+Ai+0egeIwrlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltmS6SsZUokHcRqRqT+iYDa7Z3pc5pkep29qHZ+kuZ2WzgsASnh0cTFFeSJJk4UwDZiFNsK/dY7pIWVAvF6unDT7I0sFBiE5aHhahxht4jNTgOyziEDblfm8Km+nuuz10sfGjwTdDA0wA/l2H9LiNqCCSgXD9NC/7egJn7LzrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=naeHyF9I; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 21:13:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724678024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3VzVdCX8vHAdGOmy/GRhVaeKZefcHdDx8ERim6TFk8=;
	b=naeHyF9Is5akLx8635moDlIkouTAkAQfBXFnFpGPdkOOYGzn9bImHB0R8acpKiHtxU88q8
	KgT/ute4BXfk0Sc1FpSA8xhZw2rQOMPGgzl+7Mm5989+zhprn/vHtWoJn49JoCbSpxOyAT
	5z10IH2NMqysLAABIEseG7wFca4LOFk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
	leo.yan@arm.com, ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add dso__is_pie call to identify ELF PIE
Message-ID: <20240826131341.GA4167@debian-dev>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
 <323e931fe9f8f080eb0dfc2e29d112dd7edf1fb2.1724104248.git.scclevenger@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323e931fe9f8f080eb0dfc2e29d112dd7edf1fb2.1724104248.git.scclevenger@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

Hi Steve,

On Tue, Aug 20, 2024 at 04:11:35PM -0600, Steve Clevenger wrote:
> From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
> 
> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
> the DF_1_PIE flag. This identifies position executable code.
>  
> Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
> ---
>  tools/perf/util/symbol-elf.c | 55 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e398abfd13a0..1d4bd222b314 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -662,6 +662,61 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>  	return err;
>  }
>  
> +/*
> + * Check dynamic section DT_FLAGS_1 for a Position Independent
> + * Executable (PIE).
> + */
> +bool dso__is_pie(struct dso *dso)
> +{
> +	Elf *elf = NULL;
> +	Elf_Scn *scn = NULL;
> +	GElf_Ehdr ehdr;
> +	GElf_Shdr shdr;
> +	bool is_pie = false;
> +	char dso_path[PATH_MAX];
> +	int fd = -1;
> +
> +	if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
> +		return is_pie;	// false
> +
> +	dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
> +
> +	fd = open(dso_path, O_RDONLY);
> +
> +	if (fd < 0) {
> +		pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
> +		return is_pie;	// false
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	gelf_getehdr(elf, &ehdr);
> +
> +	if (ehdr.e_type == ET_DYN) {

The code looks good to me, just several nitpicks.

To avoid indentation, we can firstly check the failure case and directly
exit for it.

        if (ehdr.e_type != ET_DYN)
                goto exit_elf_end;

> +		scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);

Ditto.

        if (!scn)
                goto exit_elf_end;

> +		if (scn) {	// check DT_FLAGS_1
> +			Elf_Data *data;
> +			GElf_Dyn *entry;
> +			int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
> +
> +			data = (Elf_Data *) elf_getdata(scn, NULL);

For a safe code, it is good to check if pointers (data and
data->d_buf) are valid before dereference them.

       if (!data || !data->d_buf)
               goto exit_elf_end;

With above changes:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> +			for (int i = 0; i < n_entries; i++) {
> +				entry = ((GElf_Dyn *) data->d_buf) + i;
> +				if (entry->d_tag == DT_FLAGS_1) {
> +					if ((entry->d_un.d_val & DF_1_PIE) != 0) {
> +						is_pie = true;
> +						break;
> +					}
> +				}
> +			} // end for
> +		}
> +	}
> +
> +	elf_end(elf);
> +	close(fd);
> +
> +	return is_pie;
> +}
> +
>  /*
>   * We need to check if we have a .dynsym, so that we can handle the
>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
> -- 
> 2.25.1
> 
> 

