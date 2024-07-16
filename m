Return-Path: <linux-kernel+bounces-254017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D0932A41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34141C2230F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09A19DFBF;
	Tue, 16 Jul 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKDyC5VK"
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BE19D8B4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143124; cv=none; b=gQ5EksNzPCh7krYv3obKQf7Lu/7mTZ2DBtfTF9MH67HvH9156E//T8AhRka84qwFQOxLTO5ggTJxj9NKg6u3xyAUw3RuOjkrjfjbkapQHKr6K51cW1QnLEMwGeABWGf7oRMO6GwDsvZue0VP6Pf7boUHsViwpFNZAtTbUK2T+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143124; c=relaxed/simple;
	bh=jgjjVzNwJT/xkHcT199d1EFANRGi8n+PpehRaui5pj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dlJFa9cpSHOAtIMeZk9uZrKdrbplxGk30eGhZ6vA7jNa5rU6GW9kxa/jWjT4zX4Rv7LVJIfLdHda4rYLXJmFL2e+MJbuJgai1/5kVyv7whCTz9zG/9MWpqIxPveHhtwaESwxx1zqTqGEVVrakybXw8NbsWaoqGc/2+jq+SoJkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKDyC5VK; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-65faa0614dbso32670027b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721143121; x=1721747921; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3BYYS8rK8sCLUm5NflzG9c4NkbLfSj0UBL6iBrYmcbk=;
        b=iKDyC5VKSglbKMGRKiapG2AQZxgfA+eDOkbn7eJ95CxgfFEUpubriAtln1DNDvoySX
         rJtUCaGOAgE3g7iKOJ9TkLk5NlajCPGSWpnciT/KIEd6dbwDDIcXIVqXB7SC33/xmksj
         Zchef/3LLwPZtBQ6sN+r0YblcnZpGGAJv1RyMYLlDXtcKgaeoGi5aZTmc0s1ZBjfETG3
         F/7OVv8Pd1I+aJ3kvKQpXPP34e15Yh4xqETec+L2qDuxGodh45skYZVHg6xJ38Nf6xnM
         j/kZ/0nzY3XP0d/oNxDyj9aRpD0CADbdgenMDdxedS+ACkjYFgxL1tI2HEa9P4ul0rOf
         m3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143121; x=1721747921;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BYYS8rK8sCLUm5NflzG9c4NkbLfSj0UBL6iBrYmcbk=;
        b=nBS8qmR+ykPzGSlXHpvK1nIL0x6jAa7vVqxZcAd5lqZPmhFx2jBGrRGNFeguNYlwFu
         n6Ti7Q+/X84xi2zcp7a7yU/87KeE2MUm96epqOL82HxdOm6EKmsg5JGZkbqTqlhj7R8R
         8VWzraLo9VxrznuMNVkqpKPWXlHNidvy1iQP/4J/4CaFNCuerQZmeFalUaNO3AYgnBk7
         iOSMrP3uWSrQxh2wXquY80pPHn6n3ORO1e5uGhdw7d4wgWF0i8SrCsUgb/JSxFXR7oVV
         JasyfkVFw1KBdc6k8ViSyypO4cOfUv7PApfojuWk3Q0zqxn0hEK2gXWVl6AZRnSFhQcj
         JTzw==
X-Gm-Message-State: AOJu0YwWc8RNFmSH+6PNN9mbSuqu0C17G3sTCNBeM3MKUevbpfJnfFFp
	F3VCzFQ7iiY9yzGADFiXOFnNQHMI5vMKyni1IewDseVW/BdDOIuAlGJncQuhU2ZVGEEnfs7hzJr
	CrIesRiSYzb+ekH6avO1hPLnCGJ1tWGNy
X-Google-Smtp-Source: AGHT+IFMXj9tCWznS/76yqeq/j8J1pO5vYnM7z25HVSjroexow/z4poWr9mlb5e3VN5bPIUxf/MH2J1UruAz4G9ifv4=
X-Received: by 2002:a05:690c:f11:b0:615:1ad2:1102 with SMTP id
 00721157ae682-6637f4a8b21mr35392297b3.11.1721143120565; Tue, 16 Jul 2024
 08:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 16 Jul 2024 20:48:29 +0530
Message-ID: <CAFf+5zh7DOrvDPZUHJyaaFvofNEEvEJCh+kAEmxJ-=7_CCTDMw@mail.gmail.com>
Subject: Generic Doubly Linked List Library (similar to C++ STL list and other
 C++ STL data structures).
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a generic linked list library implementation, similar to C++ STL list.
By using a combination of functions provided in this library, this library can
also be used as other C++ STL data structures such as - stack, queue, deque,
map, set, multimap, multiset, unordered_map, unordered_set, unordered_multimap,
and unordered_multiset.

The unique feature of this library is that it copies user's data into its
elements, so the user doesn't have to keep his/her copy of data around. User's
data safely resides in the elements.

-----------------------------------------------
An example of using this library as a 'set' is:
-----------------------------------------------

if (gdlll_peek_matching_element(...) == NULL) {
    gdlll_add_element_sorted_ascending(...);
}

----------------------------------------------------------
An example of using this library as an 'unordered_set' is:
----------------------------------------------------------

if (gdlll_peek_matching_element(...) == NULL) {
    gdlll_add_element_to_front(...);
}

-------------------------------------------------------------------------------
For using this library as a 'map', etc, your 'data_ptr' must point to a
structure that has a 'key' member and a 'value' member.

struct mymap
{
    char *key;
    int value;
};

data_ptr = malloc(sizeof(mymap));
data_ptr->key = malloc(10);
strncpy(data_ptr->key, "abcd", 10);
data_ptr->key[4] = 0;
data_ptr->value = 20;
gdlll_add_element_to_front(gdllc_ptr, data_ptr, sizeof(mymap));
-------------------------------------------------------------------------------

------------------------------------
generic_doubly_linked_list_library.h
------------------------------------


/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#ifndef _GENERIC_DOUBLY_LINKED_LIST_LIBRARY_H_
#define _GENERIC_DOUBLY_LINKED_LIST_LIBRARY_H_

// gdlll means generic doubly linked list library.
// gdllc means generic doubly linked list container.
// gdll means generic doubly linked list.

// Everything happened successfully.
#define GDLLL_SUCCESS 0

// 'gdllc_ptr' argument is NULL.
#define GDLLL_GDLLC_PTR_IS_NULL -1

// 'data_ptr' argument is NULL.
#define GDLLL_DATA_PTR_IS_NULL -2

// 'data_size' argument is <= 0.
#define GDLLL_DATA_SIZE_IS_INVALID -3

// There are no elements in the container.
#define GDLLL_CONTAINER_IS_EMPTY -4

// No memory available.
#define GDLLL_NO_MEMORY -5

// Matching element was not found in the list.
#define GDLLL_MATCHING_ELEMENT_NOT_FOUND -6

// The function pointer given by the user for comparing elements is NULL.
#define GDLLL_COMPARE_ELEMENTS_FUNC_PTR_IS_NULL -7

// This is used only for initializing error variables.
#define GDLLL_ERROR_INIT_VALUE -99

struct element
{
    void *data_ptr;
    long data_size;
    struct element *prev;
    struct element *next;
};

/*
 * The user needs to give a function pointer to compare elements in some
 * functions of this library. Below is the signature of the elements comparator
 * function.
 *
 * The return value of this function should be -1 if 'first' is less than the
 * 'second', 0 if 'first' is equal to the 'second', and 1 if 'first' is greater
 * than the 'second'.
 */
typedef int (*compare_elements_function)(struct element *first,
                                         struct element *second);

struct gdll_container
{
    struct element *first;
    struct element *last;
    long total_number_of_elements;
    // This function pointer will be called before freeing 'data_ptr' member of
    // the element structure. This will be needed if the user has allocated some
    // memory in 'data_ptr' and the user wants to free it before the 'data_ptr'
    // member is freed by this library. So, if the user has a need for it then
    // the user can give a valid function pointer to call when initializing this
    // library (by calling the function 'gdlll_init_gdll_container'). The user
    // may also give NULL function pointer if the user doesn't need this
    // functionality.
    void (*call_function_before_deleting_data)(void *data_ptr, long data_size);
};

// This function doesn't check the validity of its arguments. It is the
// responsibility of the calling function to check the arguments it is passing
// to this function.
static struct element *gdlll_create_standalone_element(void *data_ptr,
                                                       long data_size);

// This function doesn't check the validity of its arguments. It is the
// responsibility of the calling function to check the arguments it is passing
// to this function. This function just removes the element from the list,
// it doesn't decrement total_number_of_elements by 1. Decrementing has to be
// done in the calling function. This function should not be called if the
// number of elements in the container is 0. The calling function should first
// check whether the number of elements in the container is 0 or not.
static void gdlll_remove_element_from_list(struct gdll_container *gdllc_ptr,
                                           struct element *elem_ptr);

// This function doesn't check the validity of its arguments. It is the
// responsibility of the calling function to check the arguments it is passing
// to this function. This function just inserts the element in the list at the
// appropriate place, it doesn't increment total_number_of_elements by 1.
// Incrementing has to be done in the calling function. This function should not
// be called if the number of elements in the container is 0. The calling
// function should first check whether the number of elements in the container
// is 0 or not.
static void insert_element_before_element(struct gdll_container *gdllc_ptr,
                                          struct element *elem_to_insert_ptr,
                            struct element *elem_before_which_to_insert_ptr);

struct gdll_container *gdlll_init_gdll_container(
                            void *function_ptr_to_call_before_deleting_data);

// If gdllc_ptr is NULL, then this function returns 0
long gdlll_get_total_number_of_elements_in_gdll_container(
                                            struct gdll_container *gdllc_ptr);

int gdlll_add_element_to_front(struct gdll_container *gdllc_ptr, void *data_ptr,
                               long data_size);

int gdlll_add_element_to_back(struct gdll_container *gdllc_ptr, void *data_ptr,
                              long data_size);

int gdlll_add_element_sorted_ascending(struct gdll_container *gdllc_ptr,
                                       void *data_ptr, long data_size,
                                       compare_elements_function comp_func);

int gdlll_add_element_sorted_descending(struct gdll_container *gdllc_ptr,
                                        void *data_ptr, long data_size,
                                        compare_elements_function comp_func);

// All gdlll_get_* functions remove the element from the list and then return
// the element. If you don't want the element to be removed from the list then
// use gdlll_peek_* functions. If there are no elements in the container
// then NULL is returned.
struct element *gdlll_get_front_element(struct gdll_container *gdllc_ptr);

struct element *gdlll_get_last_element(struct gdll_container *gdllc_ptr);

struct element *gdlll_get_matching_element(struct gdll_container *gdllc_ptr,
                                           void *data_ptr, long data_size,
                                           compare_elements_function comp_func);

// All gdlll_peek_* functions return the element without removing it from the
// list. If there are no elements in the container then NULL is returned.
struct element *gdlll_peek_front_element(struct gdll_container *gdllc_ptr);

struct element *gdlll_peek_last_element(struct gdll_container *gdllc_ptr);

struct element *gdlll_peek_matching_element(struct gdll_container *gdllc_ptr,
                                            void *data_ptr, long data_size,
                                           compare_elements_function comp_func);

int gdlll_replace_data_in_matching_element(struct gdll_container *gdllc_ptr,
                                         void *old_data_ptr, long old_data_size,
                                         void *new_data_ptr, long new_data_size,
                                         compare_elements_function comp_func);

void gdlll_delete_front_element(struct gdll_container *gdllc_ptr);

void gdlll_delete_last_element(struct gdll_container *gdllc_ptr);

void gdlll_delete_matching_element(struct gdll_container *gdllc_ptr,
                                   void *data_ptr, long data_size,
                                   compare_elements_function comp_func);

void gdlll_delete_standalone_element(struct gdll_container *gdllc_ptr,
                                     struct element *element_to_delete);

void gdlll_delete_all_elements_in_gdll_container(
                                            struct gdll_container *gdllc_ptr);

void gdlll_delete_gdll_container(struct gdll_container *gdllc_ptr);

#endif


------------------------------------
generic_doubly_linked_list_library.c
------------------------------------


/*
 * License: This file has been released under APACHE LICENSE, VERSION 2.0
 * The license details can be found here:
 *                            https://www.apache.org/licenses/LICENSE-2.0
 */

/*
 * Author: Amit Choudhary
 * Email: amitchoudhary0523 AT gmail DOT com
 */

#include "generic_doubly_linked_list_library.h"

#include <stdlib.h>
#include <string.h>

static struct element *gdlll_create_standalone_element(void *data_ptr,
                                                       long data_size)
{
    struct element *elem_ptr = NULL;

    elem_ptr = malloc(sizeof(*elem_ptr));
    if (!elem_ptr) {
        return NULL;
    }

    elem_ptr->data_ptr = malloc((size_t)(data_size));
    if (!(elem_ptr->data_ptr)) {
        free(elem_ptr);
        return NULL;
    }

    memmove(elem_ptr->data_ptr, data_ptr, (size_t)(data_size));
    elem_ptr->data_size = data_size;

    elem_ptr->prev = NULL;
    elem_ptr->next = NULL;

    return elem_ptr;

} // end of gdlll_create_standalone_element() function

static void gdlll_remove_element_from_list(struct gdll_container *gdllc_ptr,
                                           struct element *elem_ptr)
{

    if (elem_ptr == gdllc_ptr->first) {
        gdllc_ptr->first = elem_ptr->next;
        if (gdllc_ptr->first == NULL) {
            gdllc_ptr->last = NULL;
        } else {
            gdllc_ptr->first->prev = NULL;
        }
    } else if (elem_ptr == gdllc_ptr->last) {
        gdllc_ptr->last = elem_ptr->prev;
        if (gdllc_ptr->last == NULL) {
            gdllc_ptr->first = NULL;
        } else {
            gdllc_ptr->last->next = NULL;
        }
    } else {
        elem_ptr->prev->next = elem_ptr->next;
        elem_ptr->next->prev = elem_ptr->prev;
    }

    elem_ptr->prev = NULL;
    elem_ptr->next = NULL;

} // end of gdlll_remove_element_from_list() function

static void insert_element_before_element(struct gdll_container *gdllc_ptr,
                                          struct element *elem_to_insert_ptr,
                            struct element *elem_before_which_to_insert_ptr)
{

    if (elem_before_which_to_insert_ptr == NULL) {

        // add elem_to_insert_ptr to back
        gdllc_ptr->last->next = elem_to_insert_ptr;
        elem_to_insert_ptr->prev = gdllc_ptr->last;
        gdllc_ptr->last = elem_to_insert_ptr;

    } else if (elem_before_which_to_insert_ptr == gdllc_ptr->first) {

        // add elem_to_insert_ptr to front
        elem_to_insert_ptr->next = gdllc_ptr->first;
        elem_to_insert_ptr->next->prev = elem_to_insert_ptr;
        gdllc_ptr->first = elem_to_insert_ptr;

    } else {

        // insert elem_to_insert_ptr before elem_before_which_to_insert_ptr
        elem_to_insert_ptr->next = elem_before_which_to_insert_ptr;
        elem_to_insert_ptr->prev = elem_before_which_to_insert_ptr->prev;
        elem_before_which_to_insert_ptr->prev = elem_to_insert_ptr;
        elem_to_insert_ptr->prev->next = elem_to_insert_ptr;

    }

} // end of insert_element_before_element() function

struct gdll_container *gdlll_init_gdll_container(
                            void *function_ptr_to_call_before_deleting_data)
{

    struct gdll_container *gdllc_ptr = malloc(sizeof(*gdllc_ptr));

    if (!gdllc_ptr)
        return NULL;

    gdllc_ptr->first = NULL;
    gdllc_ptr->last = NULL;
    gdllc_ptr->total_number_of_elements = 0;
    gdllc_ptr->call_function_before_deleting_data =
                                    function_ptr_to_call_before_deleting_data;

    return gdllc_ptr;

} // end of gdlll_init_gdll_container() function

long gdlll_get_total_number_of_elements_in_gdll_container(
                                            struct gdll_container *gdllc_ptr)
{

    if (!gdllc_ptr) {
        return 0;
    }

    return (gdllc_ptr->total_number_of_elements);

} // end of gdlll_get_total_number_of_elements_in_gdll_container() function

int gdlll_add_element_to_front(struct gdll_container *gdllc_ptr, void *data_ptr,
                               long data_size)
{

    struct element *elem_ptr = NULL;

    if (!gdllc_ptr) {
        return GDLLL_GDLLC_PTR_IS_NULL;
    }

    if (!data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    elem_ptr = gdlll_create_standalone_element(data_ptr, data_size);

    if (!elem_ptr) {
        return GDLLL_NO_MEMORY;
    }

    if (gdllc_ptr->first == NULL) {
        gdllc_ptr->first = elem_ptr;
        gdllc_ptr->last = elem_ptr;
    } else {
        elem_ptr->next = gdllc_ptr->first;
        elem_ptr->next->prev = elem_ptr;
        gdllc_ptr->first = elem_ptr;
    }

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements + 1;

    return GDLLL_SUCCESS;

} // end of gdlll_add_element_to_front() function

int gdlll_add_element_to_back(struct gdll_container *gdllc_ptr, void *data_ptr,
                              long data_size)
{

    struct element *elem_ptr = NULL;

    if (!gdllc_ptr) {
        return GDLLL_GDLLC_PTR_IS_NULL;
    }

    if (!data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    elem_ptr = gdlll_create_standalone_element(data_ptr, data_size);

    if (!elem_ptr) {
        return GDLLL_NO_MEMORY;
    }

    if (gdllc_ptr->first == NULL) {
        gdllc_ptr->first = elem_ptr;
        gdllc_ptr->last = elem_ptr;
    } else {
        gdllc_ptr->last->next = elem_ptr;
        elem_ptr->prev = gdllc_ptr->last;
        gdllc_ptr->last = elem_ptr;
    }

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements + 1;

    return GDLLL_SUCCESS;

} // end of gdlll_add_element_to_back() function

int gdlll_add_element_sorted_ascending(struct gdll_container *gdllc_ptr,
                                       void *data_ptr, long data_size,
                                       compare_elements_function comp_func)
{

    struct element *elem_ptr = NULL;

    if (!gdllc_ptr) {
        return GDLLL_GDLLC_PTR_IS_NULL;
    }

    if (!data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    if (!comp_func) {
        return GDLLL_COMPARE_ELEMENTS_FUNC_PTR_IS_NULL;
    }

    elem_ptr = gdlll_create_standalone_element(data_ptr, data_size);

    if (!elem_ptr) {
        return GDLLL_NO_MEMORY;
    }

    if (gdllc_ptr->first == NULL) {
        gdllc_ptr->first = elem_ptr;
        gdllc_ptr->last = elem_ptr;
    } else {
        struct element *temp = gdllc_ptr->first;
        while ((temp) && (comp_func(elem_ptr, temp) > 0)) {
            temp = temp->next;
        }
        // insert elem_ptr before temp
        insert_element_before_element(gdllc_ptr, elem_ptr, temp);
    }

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements + 1;

    return GDLLL_SUCCESS;

} // end of gdlll_add_element_sorted_ascending() function

int gdlll_add_element_sorted_descending(struct gdll_container *gdllc_ptr,
                                        void *data_ptr, long data_size,
                                        compare_elements_function comp_func)
{

    struct element *elem_ptr = NULL;

    if (!gdllc_ptr) {
        return GDLLL_GDLLC_PTR_IS_NULL;
    }

    if (!data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    if (!comp_func) {
        return GDLLL_COMPARE_ELEMENTS_FUNC_PTR_IS_NULL;
    }

    elem_ptr = gdlll_create_standalone_element(data_ptr, data_size);

    if (!elem_ptr) {
        return GDLLL_NO_MEMORY;
    }

    if (gdllc_ptr->first == NULL) {
        gdllc_ptr->first = elem_ptr;
        gdllc_ptr->last = elem_ptr;
    } else {
        struct element *temp = gdllc_ptr->first;
        while ((temp) && (comp_func(elem_ptr, temp) < 0)) {
            temp = temp->next;
        }
        // insert elem_ptr before temp
        insert_element_before_element(gdllc_ptr, elem_ptr, temp);
    }

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements + 1;

    return GDLLL_SUCCESS;

} // end of gdlll_add_element_sorted_descending() function

struct element *gdlll_get_front_element(struct gdll_container *gdllc_ptr)
{

    struct element *temp = NULL;

    if (!gdllc_ptr) {
        return NULL;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return NULL;
    }

    temp = gdllc_ptr->first;

    gdlll_remove_element_from_list(gdllc_ptr, gdllc_ptr->first);

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;

    return temp;

} // end of gdlll_get_front_element() function

struct element *gdlll_get_last_element(struct gdll_container *gdllc_ptr)
{

    struct element *temp = NULL;

    if (!gdllc_ptr) {
        return NULL;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return NULL;
    }

    temp = gdllc_ptr->last;

    gdlll_remove_element_from_list(gdllc_ptr, gdllc_ptr->last);

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;

    return temp;

} // end of gdlll_get_last_element() function

struct element *gdlll_get_matching_element(struct gdll_container *gdllc_ptr,
                                           void *data_ptr, long data_size,
                                           compare_elements_function comp_func)
{

    struct element *matching_elem_ptr = NULL;

    if (!gdllc_ptr) {
        return NULL;
    }

    if (!data_ptr) {
        return NULL;
    }

    if (data_size <= 0) {
        return NULL;
    }

    if (!comp_func) {
        return NULL;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return NULL;
    }

    matching_elem_ptr = gdlll_peek_matching_element(gdllc_ptr, data_ptr,
                                                    data_size, comp_func);

    if (matching_elem_ptr == NULL) {
        return NULL;
    }

    gdlll_remove_element_from_list(gdllc_ptr, matching_elem_ptr);

    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;

    return matching_elem_ptr;

} // end of gdlll_get_matching_element() function

struct element *gdlll_peek_front_element(struct gdll_container *gdllc_ptr)
{

    if (!gdllc_ptr) {
        return NULL;
    }

    return (gdllc_ptr->first);

} // end of gdlll_peek_front_element() function

struct element *gdlll_peek_last_element(struct gdll_container *gdllc_ptr)
{

    if (!gdllc_ptr) {
        return NULL;
    }

    return (gdllc_ptr->last);

} // end of gdlll_peek_last_element() function

struct element *gdlll_peek_matching_element(struct gdll_container *gdllc_ptr,
                                            void *data_ptr, long data_size,
                                            compare_elements_function comp_func)
{

    struct element *elem_ptr = NULL;
    struct element *temp = NULL;

    if (!gdllc_ptr) {
        return NULL;
    }

    if (!data_ptr) {
        return NULL;
    }

    if (data_size <= 0) {
        return NULL;
    }

    if (!comp_func) {
        return NULL;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return NULL;
    }

    elem_ptr = gdlll_create_standalone_element(data_ptr, data_size);

    if (!elem_ptr) {
        return NULL;
    }

    temp = gdllc_ptr->first;

    while ((temp) && (comp_func(elem_ptr, temp) != 0)) {
        temp = temp->next;
    }

    gdlll_delete_standalone_element(gdllc_ptr, elem_ptr);

    return temp;

} // end of gdlll_peek_matching_element() function

int gdlll_replace_data_in_matching_element(struct gdll_container *gdllc_ptr,
                                         void *old_data_ptr, long old_data_size,
                                         void *new_data_ptr, long new_data_size,
                                         compare_elements_function comp_func)
{

    struct element *matching_elem_ptr = NULL;
    void *temp_data_ptr = NULL;

    if (!gdllc_ptr) {
        return GDLLL_GDLLC_PTR_IS_NULL;
    }

    if (!old_data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (old_data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    if (!new_data_ptr) {
        return GDLLL_DATA_PTR_IS_NULL;
    }

    if (new_data_size <= 0) {
        return GDLLL_DATA_SIZE_IS_INVALID;
    }

    if (!comp_func) {
        return GDLLL_COMPARE_ELEMENTS_FUNC_PTR_IS_NULL;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return GDLLL_CONTAINER_IS_EMPTY;
    }

    matching_elem_ptr = gdlll_peek_matching_element(gdllc_ptr, old_data_ptr,
                                                    old_data_size, comp_func);

    if (matching_elem_ptr == NULL) {
        return GDLLL_MATCHING_ELEMENT_NOT_FOUND;
    }

    temp_data_ptr = malloc((size_t)(new_data_size));
    if (!temp_data_ptr) {
        return GDLLL_NO_MEMORY;
    }

    // Now, call the call_function_before_deleting_data() for 'data_ptr' of the
    // matching element and then free the 'data_ptr' of the matching element
    if (gdllc_ptr->call_function_before_deleting_data) {
        gdllc_ptr->call_function_before_deleting_data(
                    matching_elem_ptr->data_ptr, matching_elem_ptr->data_size);
    }
    free(matching_elem_ptr->data_ptr);

    matching_elem_ptr->data_ptr = temp_data_ptr;
    memmove(matching_elem_ptr->data_ptr, new_data_ptr, (size_t)(new_data_size));
    matching_elem_ptr->data_size = new_data_size;

    return GDLLL_SUCCESS;

} // end of gdlll_replace_data_in_matching_element() function

void gdlll_delete_front_element(struct gdll_container *gdllc_ptr)
{

    struct element *temp_elem_ptr = NULL;

    if (!gdllc_ptr) {
        return;
    }

    temp_elem_ptr = gdllc_ptr->first;

    if (temp_elem_ptr) {
        gdlll_remove_element_from_list(gdllc_ptr, temp_elem_ptr);
        gdlll_delete_standalone_element(gdllc_ptr, temp_elem_ptr);
        gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;
    }

    return;

} // end of gdlll_delete_front_element() function

void gdlll_delete_last_element(struct gdll_container *gdllc_ptr)
{

    struct element *temp_elem_ptr = NULL;

    if (!gdllc_ptr) {
        return;
    }

    temp_elem_ptr = gdllc_ptr->last;

    if (temp_elem_ptr) {
        gdlll_remove_element_from_list(gdllc_ptr, temp_elem_ptr);
        gdlll_delete_standalone_element(gdllc_ptr, temp_elem_ptr);
        gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;
    }

    return;

} // end of gdlll_delete_last_element() function

void gdlll_delete_matching_element(struct gdll_container *gdllc_ptr,
                                   void *data_ptr, long data_size,
                                   compare_elements_function comp_func)
{

    struct element *matching_elem_ptr = NULL;

    if (!gdllc_ptr) {
        return;
    }

    if (!data_ptr) {
        return;
    }

    if (data_size <= 0) {
        return;
    }

    if (!comp_func) {
        return;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return;
    }

    matching_elem_ptr = gdlll_peek_matching_element(gdllc_ptr, data_ptr,
                                                    data_size, comp_func);

    if (matching_elem_ptr == NULL) {
        return;
    }

    gdlll_remove_element_from_list(gdllc_ptr, matching_elem_ptr);
    gdlll_delete_standalone_element(gdllc_ptr, matching_elem_ptr);
    gdllc_ptr->total_number_of_elements =
                                    gdllc_ptr->total_number_of_elements - 1;

    return;

} // end of gdlll_delete_matching_element() function

void gdlll_delete_standalone_element(struct gdll_container *gdllc_ptr,
                                     struct element *element_to_delete)
{

    if (!gdllc_ptr) {
        return;
    }

    if (!element_to_delete) {
        return;
    }

    // Call the call_function_before_deleting_data() for 'data_ptr' of
    // 'element_to_delete' and then free the 'data_ptr' of 'element_to_delete'.
    // Then free the 'element_to_delete'.
    if (gdllc_ptr->call_function_before_deleting_data) {
        gdllc_ptr->call_function_before_deleting_data(
                    element_to_delete->data_ptr, element_to_delete->data_size);
    }

    free(element_to_delete->data_ptr);

    free(element_to_delete);

    return;

} // end of gdlll_delete_standalone_element() function

void gdlll_delete_all_elements_in_gdll_container(
                                            struct gdll_container *gdllc_ptr)
{

    struct element *temp_elem_ptr = NULL;

    if (!gdllc_ptr) {
        return;
    }

    if (gdllc_ptr->total_number_of_elements == 0) {
        return;
    }

    temp_elem_ptr = gdllc_ptr->first;

    while (temp_elem_ptr) {
        gdlll_delete_front_element(gdllc_ptr);
        temp_elem_ptr = gdllc_ptr->first;
    }

    return;

} // end of gdlll_delete_all_elements_in_gdll_container() function

void gdlll_delete_gdll_container(struct gdll_container *gdllc_ptr)
{

    if (!gdllc_ptr) {
        return;
    }

    gdlll_delete_all_elements_in_gdll_container(gdllc_ptr);

    free(gdllc_ptr);

    return;

} // end of gdlll_delete_gdll_container() function

