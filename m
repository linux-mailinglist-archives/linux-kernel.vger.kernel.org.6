Return-Path: <linux-kernel+bounces-251539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F22930607
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CED28235F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425413B2AC;
	Sat, 13 Jul 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFQk2s0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBF5FDA5;
	Sat, 13 Jul 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882507; cv=none; b=L4cQYlNGDwj95cgRs5YPn2gfDI2cBv7lNOS5Gvh4rmqRTCWo2tkgwNqs9R8n09CpqhsOuMyrev79BMDCdzSD1lAPO3obW0u0eUsHgV/ff6Zf16p7EKDSf4pU071gUz6UO0uA/JPEs02BNco/rk1T06VQ+dYpD0qlHDMOTBPFZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882507; c=relaxed/simple;
	bh=CpgTW3j9jumrXDBVx8Tvng0JghMcCdZ/gYyDEBGUfKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6WTfv9RhSt2vidOrDvQiYeSauCNJOljcmj/jvugRMgC1du9QJ05vEjUZ0n68ZB2/BVtE3Mlmsx10Kbrmi+ZcdETWd2cW9rXDhhr6K2Pe/QfRi837QCyd7b7Z1dapAEBNqDgHMcVT918wYnVBfKsi6f+PwuY1yKtR8jOn7rPwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFQk2s0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652D3C32781;
	Sat, 13 Jul 2024 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720882507;
	bh=CpgTW3j9jumrXDBVx8Tvng0JghMcCdZ/gYyDEBGUfKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFQk2s0XgQqEL1rElXvHl4GJw53AI/v+V6n2Xim+riQ27E/L4jBp8dFo7e7gA9Y7L
	 IcLrJ5CsleeHoBL7Ph00gJPowgXpcgc05t9KeeaMM0ThfajRC5NeET6ZxLM5xlrscB
	 GFUQYTHw0aCaAKP7L9OTOi3k631np+RM7ShkRhoH9n5k3rtDG1h89Ii14zoJAjItFe
	 cr2jgZuWorOQUMcPZAb35e9dEz4ugLBVRZEopPM+jTFp/LHtH7yoQl9dyztuycmO0k
	 4EvfCSnGXiEkJUwIg51T+jjpB+cGbDO+56Pt8xi/A6eexZpRyTa3HfzUoyuhAsXo/J
	 kQd/h2MZS+xig==
Date: Sat, 13 Jul 2024 09:55:00 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	akanksha@linux.ibm.com, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: Re: [PATCH V6 17/18] tools/perf: Update data_type_cmp and
 sort__typeoff_sort function to include var_name in comparison
Message-ID: <ZpKVROoPC5KBTPAj@google.com>
References: <20240707144419.92510-1-atrajeev@linux.vnet.ibm.com>
 <20240707144419.92510-18-atrajeev@linux.vnet.ibm.com>
 <ZpGfYVc_ewcsQxWL@google.com>
 <6733E9A7-1118-46A5-8C17-DC22A9C47207@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6733E9A7-1118-46A5-8C17-DC22A9C47207@linux.vnet.ibm.com>

On Sat, Jul 13, 2024 at 11:52:30AM +0530, Athira Rajeev wrote:
> 
> 
> > On 13 Jul 2024, at 2:55 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > On Sun, Jul 07, 2024 at 08:14:18PM +0530, Athira Rajeev wrote:
> >> Currently data_type_cmp() only compares size and type name.
> >> But in cases where the type name of two data type entries
> >> is same, but var_name is different, the comparison can't distinguish
> >> two different types.
> >> 
> >> Consider there is a "long unsigned int" with var_name as "X" and there
> >> is global variable "long unsigned int". Currently since
> >> data_type_cmp uses only type_name for comparison ( "long unsigned int"),
> >> it won't distinguish these as separate entries. Update the
> > 
> > I'm still not sure if it's ok.  It intentionally merges different
> > instances of the same type together as it's a data 'type' profile.
> > 
> > 
> >> functions "data_type_cmp" as well as "sort__typeoff_sort" to
> >> compare variable names after type name if it exists.
> >> 
> >> Also updated "hist_entry__typeoff_snprintf" to print var_name if
> >> it is set. With the changes,
> >> 
> >>     11.42%  long unsigned int  long unsigned int +0 (current_stack_pointer)
> >>     4.68%  struct paca_struct  struct paca_struct +2312 (__current)
> >>     4.57%  struct paca_struct  struct paca_struct +2354 (irq_soft_mask)
> >>     2.69%  struct paca_struct  struct paca_struct +2808 (canary)
> >>     2.68%  struct paca_struct  struct paca_struct +8 (paca_index)
> >>     2.24%  struct paca_struct  struct paca_struct +48 (data_offset)
> >>     1.43%  long unsigned int  long unsigned int +0 (no field)
> > 
> > It seems like an output of `perf report -s type,typeoff`.  But I'm
> > curious how it'd work with -s type only?  I guess it'd have two separate
> > entries for 'long unsigned int'.  Ideally we can have a single entry
> > with two different fields.
> > 
> > For example, `perf report -s type,typeoff -H`:
> > 
> >  12.85%     long unsigned int
> >     11.42%     long unsigned int +0 (current_stack_pointer)
> >      1.43%     long unsigned int +0 (no field)
> >  ...
> > 
> 
> Hi Namhyung,
> 
> Thanks for the comments.
> 
> While printing, the check for field is done only in “sort__typeoff_sort”.
> To summarise,
> 1. While adding the data type in rb node, if the entry has different field, new entry will be added. So we will have different entries in rb node if field differs.
> 2. While using sort key to display, for “typeoff”, we use sort__typeoff_sort . For “type”, we use “sort__type_sort”
> 3. In “sort__type_sort” type_name is used. Hence result will have only single entry
> 4. In “sort__typeoff_sort” we added check for “var_name” too in this patch. So result will have two entries if field differs

I see.

> 
> Example:
> 
> Using -H option,
> 
> ./perf report -s type,typeoff -H
> 
>     17.65%     struct paca_struct
>         4.68%     struct paca_struct +2312 (__current)
>         4.57%     struct paca_struct +2354 (irq_soft_mask)
>         2.69%     struct paca_struct +2808 (canary)
>         2.68%     struct paca_struct +8 (paca_index)
>         2.24%     struct paca_struct +48 (data_offset)
>         0.55%     struct paca_struct +2816 (mmiowb_state.nesting_count)
>         0.18%     struct paca_struct +2818 (mmiowb_state.mmiowb_pending)
>         0.03%     struct paca_struct +2352 (hsrr_valid)
>         0.02%     struct paca_struct +2356 (irq_work_pending)
>         0.00%     struct paca_struct +0 (lppaca_ptr)
>     12.85%     long unsigned int
>        11.42%     long unsigned int +0 (current_stack_pointer)
>         1.43%     long unsigned int +0 (no field)
> 
> As you mentioned, we have single entry with two different fields:
> 
> 12.85%     long unsigned int
>        11.42%     long unsigned int +0 (current_stack_pointer)
>         1.43%     long unsigned int +0 (no field)
> 
> With perf report -s type:
> 
>     17.65%  struct paca_struct
>     12.85%  long unsigned int
>      1.69%  struct task_struct
>      1.51%  struct rq
>      1.49%  struct pt_regs
>      1.41%  struct vm_fault
>      1.20%  struct inode
>      1.15%  struct file
>      1.08%  struct sd_lb_stats
>      0.90%  struct security_hook_list
>      0.86%  struct seq_file
>      0.79%  struct cfs_rq
>      0.78%  struct irq_desc
>      0.72%  long long unsigned int
> 
> 
> Where as with perf report -s typeoff:
> 
>     11.42%  long unsigned int +0 (current_stack_pointer)
>      4.68%  struct paca_struct +2312 (__current)
>      4.57%  struct paca_struct +2354 (irq_soft_mask)
>      2.69%  struct paca_struct +2808 (canary)
>      2.68%  struct paca_struct +8 (paca_index)
>      2.24%  struct paca_struct +48 (data_offset)
>      1.43%  long unsigned int +0 (no field)
> 
> 
> Namhyung,
> 
> If the above shared result for “type” and “typeoff” looks good and other changes are fine, I will post V7 with change for sort cmp to use cmp_null.
> Please share your response.

Great, it looks all good.  Please send v7.

But I think it's a bit late to add this to the upcoming window.

Thanks,
Namhyung

> 
> Thanks
> Athira
> 
> >> 
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/perf/util/annotate-data.c | 24 ++++++++++++++++++++++--
> >> tools/perf/util/sort.c          | 23 +++++++++++++++++++++--
> >> 2 files changed, 43 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> >> index 8d05f3dbddf6..759c6a22e719 100644
> >> --- a/tools/perf/util/annotate-data.c
> >> +++ b/tools/perf/util/annotate-data.c
> >> @@ -167,7 +167,7 @@ static void exit_type_state(struct type_state *state)
> >> }
> >> 
> >> /*
> >> - * Compare type name and size to maintain them in a tree.
> >> + * Compare type name, var_name  and size to maintain them in a tree.
> >>  * I'm not sure if DWARF would have information of a single type in many
> >>  * different places (compilation units).  If not, it could compare the
> >>  * offset of the type entry in the .debug_info section.
> >> @@ -176,12 +176,32 @@ static int data_type_cmp(const void *_key, const struct rb_node *node)
> >> {
> >> const struct annotated_data_type *key = _key;
> >> struct annotated_data_type *type;
> >> + int64_t ret = 0;
> >> 
> >> type = rb_entry(node, struct annotated_data_type, node);
> >> 
> >> if (key->self.size != type->self.size)
> >> return key->self.size - type->self.size;
> >> - return strcmp(key->self.type_name, type->self.type_name);
> >> +
> >> + ret = strcmp(key->self.type_name, type->self.type_name);
> >> + if (ret) {
> >> + return ret;
> >> + }
> > 
> > No need for the parentheses.
> Sure, will fix it
> 
> > 
> >> +
> >> + /*
> >> +  * Compare var_name if it exists for key and type.
> >> +  * If both nodes doesn't have var_name, but one of
> >> +  * them has, return non-zero. This is to indicate nodes
> >> +  * are not the same if one has var_name, but other doesn't.
> >> +  */
> >> + if (key->self.var_name && type->self.var_name) {
> >> + ret = strcmp(key->self.var_name, type->self.var_name);
> >> + if (ret)
> >> + return ret;
> >> + } else if (key->self.var_name || type->self.var_name)
> >> + return 1;
> > 
> > I think you need to compare the order properly like in cmp_null() in
> > util/sort.c.  Please see below.
> > 
> >> +
> >> + return ret;
> >> }
> >> 
> >> static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
> >> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> >> index cd39ea972193..c6d885060ee7 100644
> >> --- a/tools/perf/util/sort.c
> >> +++ b/tools/perf/util/sort.c
> >> @@ -2267,9 +2267,25 @@ sort__typeoff_sort(struct hist_entry *left, struct hist_entry *right)
> >> right_type = right->mem_type;
> >> }
> >> 
> >> + /*
> >> +  * Compare type_name first. Next, ompare var_name if it exists
> >> +  * for left and right hist_entry. If both entries doesn't have
> >> +  * var_name, but one of them has, return non-zero. This is to
> >> +  * indicate entries are not the same if one has var_name, but the
> >> +  * other doesn't.
> >> +  * If type_name and var_name is same, use mem_type_off field.
> >> +  */
> >> ret = strcmp(left_type->self.type_name, right_type->self.type_name);
> >> if (ret)
> >> return ret;
> >> +
> >> + if (left_type->self.var_name && right_type->self.var_name) {
> >> + ret = strcmp(left_type->self.var_name, right_type->self.var_name);
> >> + if (ret)
> >> + return ret;
> >> + } else if (right_type->self.var_name || left_type->self.var_name)
> >> + return 1;
> > 
> > } else if (!left_type->self.var_name != !right_type->self.var_name)
> > return cmp_null(left_type->self.var_name, right_type->self.var_name);
> > 
> > Thanks,
> > Namhyung
> > 
> Sure, will fix this
> 
> Thanks
> Athira
> 
> 
> >> +
> >> return left->mem_type_off - right->mem_type_off;
> >> }
> >> 
> >> @@ -2305,9 +2321,12 @@ static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
> >> char buf[4096];
> >> 
> >> buf[0] = '\0';
> >> - if (list_empty(&he_type->self.children))
> >> + if (list_empty(&he_type->self.children)) {
> >> snprintf(buf, sizeof(buf), "no field");
> >> - else
> >> + if (he_type->self.var_name)
> >> + strcpy(buf, he_type->self.var_name);
> >> +
> >> + } else
> >> fill_member_name(buf, sizeof(buf), &he_type->self,
> >>  he->mem_type_off, true);
> >> buf[4095] = '\0';
> >> -- 
> >> 2.43.0
> 
> 

